require 'open-uri'
require 'net/http'
heroes = %w[ Alchemist Beastmaster Brewmaster Bristleback Centaur_Warrunner Clockwerk Dragon_Knight Earth_Spirit Earthshaker Elder_Titan Huskar Io Kunkka Legion_Commander Omniknight Phoenix Sven Timbersaw Tiny Treant_Protector Tusk Abaddon Axe Chaos_Knight Doom Lifestealer Lycan Magnus Night_Stalker Pudge Sand_King Slardar Spirit_Breaker Tidehunter Underlord Undying Wraith_King Anti-Mage Bounty_Hunter Drow_Ranger Ember_Spirit Gyrocopter Juggernaut Lone_Druid Luna Mirana Monkey_King Morphling Naga_Siren Phantom_Lancer Riki Sniper Templar_Assassin Troll_Warlord Ursa Vengeful_Spirit Chen Crystal_Maiden Disruptor Enchantress Jakiro Keeper_of_the_Light Lina Nature's_Prophet Ogre_Magi Oracle Puck Rubick Shadow_Shaman Silencer Skywrath_Mage Storm_Spirit Techies Tinker Windranger Zeus Ancient_Apparition Bane Batrider Dark_Seer Dazzle Death_Prophet Enigma Invoker Leshrac Lich Lion Necrophos Outworld_Devourer Pugna Queen_of_Pain Shadow_Demon Visage Warlock Winter_Wyvern Witch_Doctor Arc_Warden Bloodseeker Broodmother Clinkz Faceless_Void Medusa Meepo Nyx_Assassin Phantom_Assassin Razor Shadow_Fiend Slark Spectre Terrorblade Venomancer Viper Weaver
]


heroes.each do |hero|
  json = Net::HTTP.get('wiki.teamliquid.net', "/dota2/api.php?page=#{hero}&action=parse&format=json&prop=wikitext")
  hash_new = {}
  stuff = JSON.parse(json)["parse"]["wikitext"]['*'].split("\n").each do |line|
    if line.include?("=")
      line = line.split("=")
      line[0] = line[0].gsub!(/[^0-9A-Za-z]/, '')
      if line[1] then line[1].gsub!(/[^0-9A-Za-z\%\+\-\ \.\/]/, '') end
      if line[0] && hash_new.keys.include?(line[0].to_sym) then line[0] = line[0] + "_1" end
      hash_new.merge!("#{line[0]}": "#{line[1]}")
    end
  end
  puts hero

  attackrangehold = hash_new[:attackrange]
  attack_range = attackrangehold.gsub(/[^\d,\.]/, '').to_i
  attack_type = attackrangehold.gsub!(/[^A-Za-z]/, '')
  attack_type.slice!("abbr")

  hash_new[:t1left].slice!("talent")
  hash_new[:t1right].slice!("talent")
  hash_new[:t2left].slice!("talent")
  hash_new[:t2right].slice!("talent")
  hash_new[:t3left].slice!("talent")
  hash_new[:t3right].slice!("talent")
  hash_new[:t4left].slice!("talent")
  hash_new[:t4right].slice!("talent")

  Hero.create!(name: hash_new[:heroname], base_str: hash_new[:basestr], add_str: hash_new[:strgain], base_agi: hash_new[:baseagi], add_agi: hash_new[:agigain], base_int: hash_new[:baseint], add_int: hash_new[:intgain], move_speed: hash_new[:basespeed], turn_rate: hash_new[:basespeed], attack_type: attack_type, hero_type: hash_new[:mainattribute], attack_range: attack_range, talents: {
    level10: [hash_new[:t1left], hash_new[:t1right]],
    level15: [hash_new[:t2left], hash_new[:t2right]],
    level20: [hash_new[:t3left], hash_new[:t3right]],
    level25: [hash_new[:t4left], hash_new[:t4right]]
  })
end
