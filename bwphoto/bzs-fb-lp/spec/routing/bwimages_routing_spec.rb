require "spec_helper"

describe BwimagesController do
  describe "routing" do

    it "routes to #index" do
      get("/bwimages").should route_to("bwimages#index")
    end

    it "routes to #new" do
      get("/bwimages/new").should route_to("bwimages#new")
    end

    it "routes to #show" do
      get("/bwimages/1").should route_to("bwimages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bwimages/1/edit").should route_to("bwimages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bwimages").should route_to("bwimages#create")
    end

    it "routes to #update" do
      put("/bwimages/1").should route_to("bwimages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bwimages/1").should route_to("bwimages#destroy", :id => "1")
    end

  end
end
