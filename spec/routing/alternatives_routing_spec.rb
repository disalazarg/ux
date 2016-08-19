require "rails_helper"

RSpec.describe AlternativesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/alternatives").to route_to("alternatives#index")
    end

    it "routes to #new" do
      expect(:get => "/alternatives/new").to route_to("alternatives#new")
    end

    it "routes to #show" do
      expect(:get => "/alternatives/1").to route_to("alternatives#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/alternatives/1/edit").to route_to("alternatives#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/alternatives").to route_to("alternatives#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/alternatives/1").to route_to("alternatives#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/alternatives/1").to route_to("alternatives#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/alternatives/1").to route_to("alternatives#destroy", :id => "1")
    end

  end
end
