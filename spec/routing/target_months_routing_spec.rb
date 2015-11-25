require "spec_helper"

describe TargetMonthsController do
  describe "routing" do

    it "routes to #index" do
      get("/target_months").should route_to("target_months#index")
    end

    it "routes to #new" do
      get("/target_months/new").should route_to("target_months#new")
    end

    it "routes to #show" do
      get("/target_months/1").should route_to("target_months#show", :id => "1")
    end

    it "routes to #edit" do
      get("/target_months/1/edit").should route_to("target_months#edit", :id => "1")
    end

    it "routes to #create" do
      post("/target_months").should route_to("target_months#create")
    end

    it "routes to #update" do
      put("/target_months/1").should route_to("target_months#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/target_months/1").should route_to("target_months#destroy", :id => "1")
    end

  end
end
