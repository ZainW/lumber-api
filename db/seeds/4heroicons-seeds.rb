json = JSON.parse(IO.read(Rails.root.join('lib', 'dotaconstants', 'hero_names.json')))
json.each do |heroblob|
  hero = Hero.search(heroblob[1]['localized_name']).results.first
  hero.profile_url = "http://cdn.dota2.com#{heroblob[1]['icon']}"
  hero.save
end
