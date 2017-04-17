class Hero < ApplicationRecord
  validates_presence_of :name, :base_str, :base_agi, :base_int, :add_str, :add_agi, :add_int, :move_speed, :turn_rate, :attack_type, :hero_type, :attack_range

  has_many :abilities
  searchkick
  def search_data
    {
      name: name
    }
  end
end
