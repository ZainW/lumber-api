class Ability < ApplicationRecord
  belongs_to :hero
  validates_presence_of :name, :hero_id
end
