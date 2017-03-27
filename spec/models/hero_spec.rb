require 'rails_helper'

RSpec.describe Hero, type: :model do
  # it { should have_many(:abilities) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:base_str) }
  it { should validate_presence_of(:base_agi) }
  it { should validate_presence_of(:base_int) }
  it { should validate_presence_of(:add_str) }
  it { should validate_presence_of(:add_agi) }
  it { should validate_presence_of(:add_int) }
  it { should validate_presence_of(:move_speed) }
  it { should validate_presence_of(:turn_rate) }
  it { should validate_presence_of(:attack_type) }
  it { should validate_presence_of(:hero_type) }
  it { should validate_presence_of(:attack_range) }
end
