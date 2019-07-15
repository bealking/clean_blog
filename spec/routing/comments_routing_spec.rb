require "rails_helper"

RSpec.describe CommentsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/comments").to route_to("comments#create")
    end

    it "routes to #index" do
      expect(get: "/comments").to route_to("comments#index")
    end
  end
end
