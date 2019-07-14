require "rails_helper"

RSpec.describe UsersController, :type => :routing do

  describe "routing" do

    it "routes to #new" do
      expect(get: "/users/new").to route_to("users#new")
    end

    it "routes to #not_authenticated" do
      expect(get: "/users/not_authenticated").to route_to("users#not_authenticated")
    end

    it "routes to #create" do
      expect(post: "/users").to route_to("users#create")
    end

    it "routes to #sign_in" do
      expect(post: "/users/sign_in").to route_to("users#sign_in")
    end
  end
end
