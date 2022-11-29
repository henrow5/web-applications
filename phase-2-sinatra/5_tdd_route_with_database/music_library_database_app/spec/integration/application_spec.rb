require "spec_helper"
require "rack/test"
require_relative "../../app"

def reset_tables
  artist_sql = File.read("spec/seeds/artists_seeds.sql")
  album_sql = File.read("spec/seeds/albums_seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
  connection.exec(artist_sql)
  connection.exec(album_sql)
end

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do
    reset_tables
  end

  context "Get /albums" do
    it "should return the list of albums" do
      response = get("/albums")

      expected_response = "Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring"
      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context "POST /albums" do
    it "200 OK and creates a new album" do
      response = post("/albums", title: "voyager", release_year: "2022", artist_id: "2")

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get("/albums")
      expect(response.status).to eq(200)
      expect(response.body).to include("voyager")
    end

    it "returns 404 Not Found" do
      response = post("/albumz")

      expect(response.status).to eq(404)
    end
  end

  context "GET /artists" do
    it "returns 200 OK and returns a list of artists" do
      response = get("/artists")

      expect(response.status).to eq(200)
      expect(response.body).to eq("Pixies, ABBA, Taylor Swift, Nina Simone")
    end

    it "returns 404 Not Found" do
      response = get("/artistz")

      expect(response.status).to eq(404)
    end
  end

  context "POST /artists" do
    it "returns 200 OK and creates a new artist" do
      # Assuming the post with id 1 exists.
      response = post("/artists", name: "Wild nothing", genre: "Indie")

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get("/artists")
      expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing"
      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end

    it "returns 404 Not Found" do
      response = post("/artistz")

      expect(response.status).to eq(404)
    end
  end
end
