FactoryGirl.define do
  factory :ability do
    name { Faker::Hacker.verb }
    more {
      {
        something: "more",
        is: "coming"
      }
    }
    hero_id nil

  end
end
