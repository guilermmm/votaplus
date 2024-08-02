require "rails_helper"

RSpec.describe EleitoresController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/eleitores").to route_to("eleitores#index")
    end

    it "routes to #new" do
      expect(get: "/eleitores/new").to route_to("eleitores#new")
    end

    it "routes to #show" do
      expect(get: "/eleitores/1").to route_to("eleitores#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/eleitores/1/edit").to route_to("eleitores#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/eleitores").to route_to("eleitores#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/eleitores/1").to route_to("eleitores#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/eleitores/1").to route_to("eleitores#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/eleitores/1").to route_to("eleitores#destroy", id: "1")
    end
  end
end
