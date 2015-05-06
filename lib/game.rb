require 'rubygems'
require 'data_mapper'

class Game
  include DataMapper::Resource
  property :id, Serial
  property :title, String, required: true
  property :score, Float, required: true
end
