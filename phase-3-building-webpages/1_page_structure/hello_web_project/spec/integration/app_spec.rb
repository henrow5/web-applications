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

  context "POST /sort-names" do
    it "returns a string of 5 sorted names" do
      response = post("/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end

    it "returns a string of 3 sorted names" do
      response = post("/sort-names", names: "Ben,Adrian,Chris")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Adrian,Ben,Chris")
    end
  end

  context "GET /hello" do
    it "returns the greeting message as an HTML page" do
      response = get("/hello")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Hello!</h1>")
    end
  end
end
