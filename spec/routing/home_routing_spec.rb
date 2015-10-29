require "rails_helper"

RSpec.describe HomeController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/").to route_to("home#index")
    end

    it "routes to #add_to_cart" do
      expect(:post => "home/add_to_cart").to route_to("home#add_to_cart")
    end
  end
end
