class Hero < ApplicationRecord
  require 'csv'
  validates_presence_of :name, :base_str, :base_agi, :base_int, :add_str, :add_agi, :add_int, :move_speed, :turn_rate, :attack_type, :hero_type, :attack_range

  has_many :abilities
  searchkick synonyms: -> {CSV.read(Rails.root.join('lib', 'synonyms', 'hero_aliases.csv'))}
  def search_data
    {
      name: name
    }
  end
end
