gem "minitest"
require 'rack/test'
require 'minitest/autorun'
require_relative '../lib/metacritic_parser.rb'

describe "Parse top PS3 games" do
  before do
    @test_data_dir = File.join(File.dirname(__FILE__), 'test_data')
  end
  it "gracefully handles invalid html page" do
    games = MetaCriticParser.new.parse_top_ps3_games(File.join(@test_data_dir, 'bad.html'))
    games.must_be_empty
  end

  it "gracefully handles html of different format" do
    games = MetaCriticParser.new.parse_top_ps3_games(File.join(@test_data_dir, 'valid_but_different_format.html'))
    games.must_be_empty
  end

  it "successfully parse html of expected format" do
    games = MetaCriticParser.new.parse_top_ps3_games(File.join(@test_data_dir, 'valid.html'))
    games.size.must_equal 4
    games[0][:title].must_equal "Under Night In-Birth Exe:Late"
  end
end
