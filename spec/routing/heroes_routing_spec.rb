require "rails_helper"

RSpec.describe HeroesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/heroes").to route_to("heroes#index")
    end

    # it "routes to #new" do
    #   expect(:get => "/heroes/new").to route_to("heroes#new")
    # end

    it "routes to #show" do
      expect(:get => "/heroes/Anti-Mage").to route_to("heroes#show", :name => "Anti-Mage")
    end

    # it "routes to #edit" do
    #   expect(:get => "/heroes/Anti/edit").to route_to("heroes#edit", :name => "Anti")
    # end

    it "routes to #create" do
      expect(:post => "/heroes").to route_to("heroes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/heroes/Anti").to route_to("heroes#update", :name => "Anti")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/heroes/Anti").to route_to("heroes#update", :name => "Anti")
    end

    it "routes to #destroy" do
      expect(:delete => "/heroes/Anti").to route_to("heroes#destroy", :name => "Anti")
    end

  end
end
