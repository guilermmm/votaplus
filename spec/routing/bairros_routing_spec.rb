require "rails_helper"

RSpec.describe BairrosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/bairros").to route_to("bairros#index")
    end

    it "routes to #new" do
      expect(get: "/bairros/new").to route_to("bairros#new")
    end

    it "routes to #show" do
      expect(get: "/bairros/1").to route_to("bairros#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/bairros/1/edit").to route_to("bairros#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/bairros").to route_to("bairros#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/bairros/1").to route_to("bairros#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/bairros/1").to route_to("bairros#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/bairros/1").to route_to("bairros#destroy", id: "1")
    end
  end
end
