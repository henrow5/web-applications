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

  context "GET /albums/:id" do
    it "returns album 1 infomation" do
      response = get("/albums/1")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Doolittle</h1>")
      expect(response.body).to include("Release year: 1989")
      expect(response.body).to include("Artist: Pixies")
    end

    it "returns album 2 infomation" do
      response = get("/albums/2")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Surfer Rosa</h1>")
      expect(response.body).to include("Release year: 1988")
      expect(response.body).to include("Artist: Pixies")
    end
  end

  # context "Get /albums" do
  # it "should return the list of albums" do
  #   response = get("/albums")

  #   expected_response = "Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring"
  #   expect(response.status).to eq(200)
  #   expect(response.body).to eq(expected_response)
  # end

  context "Get /albums" do
    it "returns 200 OK and a list of albums as an HTML page" do
      response = get("/albums")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Albums</h1>")
      expect(response.body).to include("Doolittle")
      expect(response.body).to include("Released: 1989")
      expect(response.body).to include("Surfer Rosa")
      expect(response.body).to include("Released: 1988")
      expect(response.body).to include("Waterloo")
      expect(response.body).to include("Released: 1974")
    end

    it "returns 200 OK and a list of linked albums as an HTML page" do
      response = get("/albums")

      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/albums/1">Doolittle</a>')
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a>')
      expect(response.body).to include('<a href="/albums/3">Waterloo</a>')
    end
  end

  context "GET /albums/new" do
    it "should return the form to add a new album" do
      response = get("/albums/new")

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/albums">')
      expect(response.body).to include('<input type="text" name="title" />')
      expect(response.body).to include('<input type="text" name="release_year" />')
      expect(response.body).to include('<input type="text" name="artist_id" />')
    end
  end

  context "POST /albums" do
    it "should validate album parameters" do
      response = post(
        "/albums",
        invalid_artist_title: "OK Computer",
        another_invalid_thing: 123,
      )

      expect(response.status).to eq(400)
    end

    it "200 OK and creates a new album" do
      response = post(
        "/albums",
        title: "voyager",
        release_year: "2022",
        artist_id: "2",
      )

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

  # context "GET /artists" do
  #   it "returns 200 OK and returns a list of artists" do
  #     response = get("/artists")

  #     expect(response.status).to eq(200)
  #     expect(response.body).to eq("Pixies, ABBA, Taylor Swift, Nina Simone")
  #   end

  #   it "returns 404 Not Found" do
  #     response = get("/artistz")

  #     expect(response.status).to eq(404)
  #   end
  # end

  context "POST /artists" do
    it "returns 200 OK and creates a new artist" do
      # Assuming the post with id 1 exists.
      response = post("/artists", name: "Wild nothing", genre: "Indie")

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get("/artists")
      # expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing"
      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
      expect(response.body).to include("Wild nothing")
    end

    it "returns 404 Not Found" do
      response = post("/artistz")

      expect(response.status).to eq(404)
    end

    it "should validate artist parameters" do
      response = post(
        "/artists",
        invalid_artist_name: "John",
        another_invalid_thing: 123,
      )
      expect(response.status).to eq(400)
    end
  end

  context "GET /artists/:id" do
    it "returns artist 1 infomation" do
      response = get("/artists/1")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Pixies</h1>")
      expect(response.body).to include("Genre: Rock")
    end

    it "returns artist 2 infomation" do
      response = get("/artists/2")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>ABBA</h1>")
      expect(response.body).to include("Genre: Pop")
    end
  end

  context "GET /artists" do
    it "returns 200 OK and a list of artists as an HTML page" do
      response = get("/artists")

      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/artists/1">Pixies</a><br />')
      expect(response.body).to include('<a href="/artists/2">ABBA</a><br />')
      expect(response.body).to include('<a href="/artists/3">Taylor Swift</a><br />')
    end
  end

  context "GET /artists/new" do
    it "should return a form to add a new artist" do
      response = get("/artists/new")

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/artists">')
      expect(response.body).to include('<input type="text" name="name" />')
      expect(response.body).to include('<input type="text" name="genre" />')
    end
  end
end
