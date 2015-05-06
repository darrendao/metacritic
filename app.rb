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

puts "sqlite3://#{Dir.pwd}/#{env}.db"

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

# Namespacing the API for version 1
namespace '/api/v1' do
  get '/hi' do
    "Hello World!"
  end

  get '/games' do
    games = Game.all
    games.to_json(:only => [:title, :score])
  end

  get '/games/:title' do
    game = Game.first(title: params['title'])
    if(game)
      game.to_json(:only => [:title, :score])
    else
      {}.to_json
    end
  end
end
