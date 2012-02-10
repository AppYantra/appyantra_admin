require "spec_helper"

describe AppyantraAdmin::SessionsController do
  describe "routing" do

    it "routes to #index" do
      get("/appyantra_admin/sign_in").should route_to("appyantra_admin/sessions#new")
    end

  end
end