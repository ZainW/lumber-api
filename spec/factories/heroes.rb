FactoryGirl.define do
  attack_type = ["Ranged", "Melee"]
  factory :hero do
    name { Faker::Pokemon.name }
    profile_url { Faker::LoremPixel.image("50x60", false, 'technics') }

    base_str { Faker::Number.decimal(2) }
    base_agi { Faker::Number.decimal(2) }
    base_int { Faker::Number.decimal(2) }

    add_str { Faker::Number.decimal(1,1) }
    add_agi { Faker::Number.decimal(1,1) }
    add_int { Faker::Number.decimal(1,1) }

    move_speed { Faker::Number.number(3) }
    turn_rate { Faker::Number.decimal(1.1) }
    attack_type { attack_type[rand(0..1)] }
    hero_type "Agility"
    attack_range { Faker::Number.number(3) }

    # talents {
    #   {
    #     level_10: ["talent 1", "talent 2"],
    #     level_15: ["talent 3", "talent 3"],
    #     level_20: ["talent 4", "talent 5"],
    #     level_25: ["talent 6", "talent 7"]
    #   }
    # }
  end
end
