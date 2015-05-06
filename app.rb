# encoding: UTF-8
require 'rubygems'
require 'sinatra'
require 'json'
require 'data_mapper'
require "sinatra/namespace"
require "sinatra/base"
require './lib/game.rb'

configure :development, :test, :production do
  register ::Sinatra::Namespace
  set :protection, true
  set :protect_from_csrf, true
end

env = ENV['RACK_ENV'] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/#{env}.db")
DataMapper.finalize
DataMapper.auto_upgrade!

# Namespacing the API for version 1
namespace '/api/v1' do

  # matches "GET /api/v1/games, returns list of all games
  get '/games' do
    games = Game.all
    games.to_json(:only => [:title, :score])
  end

  # matches "GET /api/v1/games/foo, returns json for game with title foo
  get '/games/:title' do
    game = Game.first(title: params['title'])
    if(game)
      game.to_json(:only => [:title, :score])
    else  # no game found
      {}.to_json
    end
  end
end
