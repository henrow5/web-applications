require "sinatra/base"
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    return erb(:index)
  end

  post "/hello" do
    @name = params[:name]

    return "Invalid name" if @name.match(/\W/)

    return erb(:hello)
  end
end
