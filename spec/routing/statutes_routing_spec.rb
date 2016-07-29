require "rails_helper"

RSpec.describe StatutesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/statutes").to route_to("statutes#index")
    end

    it "routes to #new" do
      expect(:get => "/statutes/new").to route_to("statutes#new")
    end

    it "routes to #show" do
      expect(:get => "/statutes/1").to route_to("statutes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/statutes/1/edit").to route_to("statutes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/statutes").to route_to("statutes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/statutes/1").to route_to("statutes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/statutes/1").to route_to("statutes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/statutes/1").to route_to("statutes#destroy", :id => "1")
    end

  end
end
