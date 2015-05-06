# Rakefile
require 'json'
require 'rake/testtask'
require './lib/metacritic_parser.rb'

task :default => :test

desc "Run all tests"
task :test do
  Rake::TestTask.new do |t|
    t.pattern = "spec/*_spec.rb"
  end
end

namespace :parse do
  task :top_ps3_games do
    url = "http://www.metacritic.com/game/playstation-3"
    mc_parser = MetaCriticParser.new
    games = mc_parser.parse_top_ps3_games(url)
    puts games.to_json
  end
end

namespace :db do
  task :populate_top_ps3_games do
    url = "http://www.metacritic.com/game/playstation-3"
    mc_parser = MetaCriticParser.new
    games = mc_parser.parse_top_ps3_games(url)
    mc_parser.populate_db(games)
  end

  task :populate_sample_ps3_games do
    url = "http://www.metacritic.com/browse/games/release-date/available/ps3/metascore?page=1"
    mc_parser = MetaCriticParser.new
    games = mc_parser.parse_all_ps3_games(url)
    mc_parser.populate_db(games)
  end
end
