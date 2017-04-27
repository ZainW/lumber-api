require 'open-uri'
require 'net/http'

items = %w[ Clarity Faerie_Fire Tango Healing_Salve Enchanted_Mango Town_Portal_Scroll Smoke_of_Deceit Dust_of_Appearance Animal_Courier Flying_Courier Observer_Ward Sentry_Ward Bottle Tome_of_Knowledge Iron_Branch Gauntlets_of_Strength Slippers_of_Agility Mantle_of_Intelligence Circlet Belt_of_Strength Band_of_Elvenskin Robe_of_the_Magi Ogre_Club Blade_of_Alacrity Staff_of_Wizardry Ring_of_Protection Stout_Shield Quelling_Blade Infused_Raindrop Orb_of_Venom Blight_Stone Blades_of_Attack Chainmail Quarterstaff Helm_of_Iron_Will Broadsword Claymore Javelin Mithril_Hammer Magic_Stick Wind_Lace Sage's_Mask Ring_of_Regen Boots_of_Speed Gloves_of_Haste Cloak Ring_of_Health Void_Stone Gem_of_True_Sight Morbid_Mask Shadow_Amulet Ghost_Scepter Blink_Dagger Magic_Wand Null_Talisman Wraith_Band Bracer Poor_Man's_Shield Soul_Ring Phase_Boots Power_Treads Oblivion_Staff Perseverance Hand_of_Midas Boots_of_Travel Moon_Shard Ring_of_Basilius Iron_Talon Headdress Buckler Urn_of_Shadows Tranquil_Boots Ring_of_Aquila Medallion_of_Courage Arcane_Boots Drum_of_Endurance Mekansm Vladmir's_Offering Pipe_of_Insight Guardian_Greaves Glimmer_Cape Force_Staff Veil_of_Discord Aether_Lens Necronomicon Dagon Eul's_Scepter_of_Divinity Solar_Crest Rod_of_Atos Orchid_Malevolence Aghanim's_Scepter Refresher_Orb Scythe_of_Vyse Octarine_Core Crystalys Armlet_of_Mordiggian Skull_Basher Shadow_Blade Battle_Fury Ethereal_Blade Silver_Edge Radiance Monkey_King_Bar Daedalus Butterfly Divine_Rapier Abyssal_Blade Bloodthorn Hood_of_Defiance Vanguard Blade_Mail Soul_Booster Crimson_Guard Black_King_Bar Lotus_Orb Hurricane_Pike Shiva's_Guard Linken's_Sphere Bloodstone Manta_Style Assault_Cuirass Heart_of_Tarrasque Mask_of_Madness Helm_of_the_Dominator Dragon_Lance Sange Yasha Echo_Sabre Maelstrom Diffusal_Blade Desolator Heaven's_Halberd Sange_and_Yasha Eye_of_Skadi Mjollnir Satanic Energy_Booster Vitality_Booster Point_Booster Platemail Talisman_of_Evasion Hyperstone Ultimate_Orb Demon_Edge Mystic_Staff Reaver Eaglesong Sacred_Relic Cheese]

items.each do |item|
  puts item
  item_web = CGI::escape(item)
  json = Net::HTTP.get('wiki.teamliquid.net', "/dota2/api.php?page=#{item_web}&action=parse&format=json&prop=wikitext")
  hash_new = {}
  stuff = JSON.parse(json)["parse"]["wikitext"]['*'].split("\n").each do |line|
    pattern = /\|title\d*=(.*)\|value\d*=(.*)/
    if pattern =~ line
      matches = pattern.match(line)
      title = matches[1].strip
      value = matches[2].strip

      hash_new[title] = value
    elsif line.include?("=")
      line = line.split("=")
      line[0] = line[0].gsub!(/[^0-9A-Za-z]/, '')
      if line[1] then line[1].gsub!(/[^0-9A-Za-z\%\+\-\ \.]/, '') end
      if line[0] && hash_new.keys.include?(line[0].to_sym) then line[0] = line[0] + "_1" end
      hash_new[line[0]] = line[1]
    end
  end
  Item.create!(name: hash_new["itemname"], more: hash_new)
end
Item.reindex
