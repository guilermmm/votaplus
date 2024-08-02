require "rails_helper"

RSpec.describe CandidatosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/candidatos").to route_to("candidatos#index")
    end

    it "routes to #new" do
      expect(get: "/candidatos/new").to route_to("candidatos#new")
    end

    it "routes to #show" do
      expect(get: "/candidatos/1").to route_to("candidatos#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/candidatos/1/edit").to route_to("candidatos#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/candidatos").to route_to("candidatos#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/candidatos/1").to route_to("candidatos#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/candidatos/1").to route_to("candidatos#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/candidatos/1").to route_to("candidatos#destroy", id: "1")
    end
  end
end
