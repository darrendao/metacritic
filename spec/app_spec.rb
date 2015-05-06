ENV['RACK_ENV'] = 'test'
gem "minitest"
require 'rack/test'
require 'minitest/autorun'
require_relative '../app.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "GET all games" do
  before do
    Game.all.destroy
    @game1 = {title: "Game 1", score: 87}
    @game2 = {title: "Game 2", score: 88}
    Game.create(@game1)
    Game.create(@game2)
  end

  it "responds with correct games" do
    get "api/v1/games"
    last_response.status.must_equal 200
    games = JSON.parse(last_response.body)
    games.size.must_equal 2
    games[0]['title'].must_equal @game1[:title]
    games[1]['score'].must_equal @game2[:score]
  end
end

describe "GET a specific game" do
  before do
    @game1 = {title: "Game 1", score: 87} 
    @game2 = {title: "Game 2", score: 88} 
    Game.all.destroy
    Game.create(@game1)
    Game.create(@game2)
  end
  describe "game does not exists" do
    it "responds with correct game" do
      get URI.encode("api/v1/games/non existing game")
      last_response.body.must_equal "{}"
    end
  end
  describe "game exists" do
    it "responds with correct game" do
      get URI.encode("api/v1/games/Game 1")
      JSON.parse(last_response.body)['title'].must_equal @game1[:title]
    end
  end
end
