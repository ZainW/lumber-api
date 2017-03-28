require 'rails_helper'

RSpec.describe Ability, type: :model do
  it { should belong_to(:hero) }
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:hero_id)}
end
