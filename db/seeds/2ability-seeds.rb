require 'open-uri'
heroes = %w[ Alchemist Beastmaster Brewmaster Bristleback Centaur_Warrunner Clockwerk Dragon_Knight Earth_Spirit Earthshaker Elder_Titan Huskar Io Kunkka Legion_Commander Omniknight Phoenix Sven Timbersaw Tiny Treant_Protector Tusk Abaddon Axe Chaos_Knight Doom Lifestealer Lycan Magnus Night_Stalker Pudge Sand_King Slardar Spirit_Breaker Tidehunter Underlord Undying Wraith_King Anti-Mage Bounty_Hunter Drow_Ranger Ember_Spirit Gyrocopter Juggernaut Lone_Druid Luna Mirana Monkey_King Morphling Naga_Siren Phantom_Lancer Riki Sniper Templar_Assassin Troll_Warlord Ursa Vengeful_Spirit Chen Crystal_Maiden Disruptor Enchantress Jakiro Keeper_of_the_Light Lina Nature's_Prophet Ogre_Magi Oracle Puck Rubick Shadow_Shaman Silencer Skywrath_Mage Storm_Spirit Techies Tinker Windranger Zeus Ancient_Apparition Bane Batrider Dark_Seer Dazzle Death_Prophet Enigma Invoker Leshrac Lich Lion Necrophos Outworld_Devourer Pugna Queen_of_Pain Shadow_Demon Visage Warlock Winter_Wyvern Witch_Doctor Arc_Warden Bloodseeker Broodmother Clinkz Faceless_Void Medusa Meepo Nyx_Assassin Phantom_Assassin Razor Shadow_Fiend Slark Spectre Terrorblade Venomancer Viper Weaver
]
heroes.each do |hero|
  json = Net::HTTP.get('wiki.teamliquid.net', "/dota2/api.php?page=#{hero}&action=parse&format=json&prop=wikitext")
  hash_new = {}
  stuff = JSON.parse(json)["parse"]["wikitext"]['*'].split("\n").each do |line|
    if line.include?("           ") then line.split("           ") end
    if line.include?("=")
      line = line.split("=")
      line[0] = line[0].gsub!(/[^0-9A-Za-z]/, '')
      if line[1] then line[1].gsub!(/[^0-9A-Za-z\%\+\-\ ]/, '') end
      if line[0] && hash_new.keys.include?(line[0].to_sym) then line[0] = line[0] + "_1" end
      hash_new.merge!("#{line[0]}": "#{line[1]}")
    end
  end
  starts = []
  ends = []
  test = JSON.parse(json)["parse"]["wikitext"]['*'].split("\n").to_a.each_with_index do |line, index|
    if line.strip == "{{SpellCard"
      starts << index
    elsif line.strip == "}}"
      ends << index
    end
  end
  ends.delete(ends.first)
  ends.delete(ends.last)
  spells = []

  starts.each_with_index do |start, index|

    range = (start..ends[index])
    spell_hash = {}
    stuff[range].each do |line|
      if line.include?("=")
        line = line.split("=", 2)
        line[0] = line[0].gsub!(/[^0-9A-Za-z]/, '')
        if line[1] then line[1].gsub!(/[^0-9A-Za-z\%\+\-\ \×\/\.]/, '') end
        if line[1] === "" then line[1] = "0" end
        # if line[0] && spell.keys.include?(line[0].to_sym) then line[0] = line[0] + "_1" end
        spell_hash.merge!("#{line[0]}": "#{line[1]}")
      end
    end
    spells << spell_hash
  end

  spells.each do |spell|
    puts hero
    Ability.create(name: spell[:name], more: spell, hero_id: Hero.find_by(name: hero.gsub("_", " ").gsub("'", "")).id)
  end

end
Ability.reindex
