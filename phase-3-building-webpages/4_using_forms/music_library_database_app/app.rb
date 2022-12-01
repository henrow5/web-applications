# file: app.rb
require "sinatra"
require "sinatra/reloader"
require_relative "lib/database_connection"
require_relative "lib/album_repository"
require_relative "lib/artist_repository"

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload "lib/album_repository"
    also_reload "lib/artist_repository"
  end

  get "/" do
    return erb(:index)
  end

  get "/about" do
    return erb(:about)
  end

  get "/albums" do
    # repo = AlbumRepository.new
    # albums = repo.all

    # response = albums.map do |album|
    #   album.title
    # end.join(", ")

    # return response
    repo = AlbumRepository.new
    @albums = repo.all

    return erb(:albums)
  end

  get "/albums/new" do
    return erb(:new_album)
  end

  get "/albums/:id" do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new

    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  post "/albums" do
    if invalid_request_parameters?
      status 400
      return ""
    end

    repo = AlbumRepository.new

    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]

    repo.create(album)

    return ""
  end

  get "/artists" do
    # repo = ArtistRepository.new

    # artists = repo.all

    # response = artists.map do |artist|
    #   artist.name
    # end.join(", ")

    # return response
    repo = ArtistRepository.new
    @artists = repo.all

    return erb(:artists)
  end

  post "/artists" do
    if invalid_artist_request_parameters?
      status 400
      return ""
    end

    repo = ArtistRepository.new

    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    repo.create(artist)

    return ""
  end

  get "/artists/new" do
    return erb(:new_artist)
  end

  get "/artists/:id" do
    artist_repo = ArtistRepository.new
    @artist = artist_repo.find(params[:id])

    return erb(:artist)
  end

  def invalid_request_parameters?
    return (params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil)
  end

  def invalid_artist_request_parameters?
    return (params[:name] == nil || params[:genre] == nil)
  end
end
