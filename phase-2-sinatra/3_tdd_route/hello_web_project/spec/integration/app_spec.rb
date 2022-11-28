# file: spec/integration/application_spec.rb

require "spec_helper"
require "rack/test"
require_relative "../../app"

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /names" do
    it "returns a string of names" do
      response = get("/names?names=Julia, Mary, Karim")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end

    it "returns a string of names" do
      response = get("/names?names=Bruce, Clark, Diana")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Bruce, Clark, Diana")
    end
  end
end
