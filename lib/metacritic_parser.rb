$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'nokogiri'         
require 'open-uri'
require 'json'
require 'game.rb'

class MetaCriticParser
  # Parses given URL (could be local or remote) and returns
  # list of all ps3 games. Returns empty list if unable to parse html
  def parse_all_ps3_games(url)
    games = []
    page = fetch_html(url)
    return games if page.nil? # return early if there's problem parsing

    page.css('div.product_condensed ol.list_products div.product_wrap').each do |prod|
      title = prod.css('a').text
      score = prod.css('div.metascore_w').text
      games << {title: title.strip, score: score}
    end
    return games
  end

  # Parses given URL (could be local or remote) and returns
  # list of top ps3 games. Returns empty list if unable to parse html
  def parse_top_ps3_games(url)
    games = []
    page = fetch_html(url)
    return games if page.nil? # return early if there's problem parsing

    page.css('div.main_stats').each do |prod|
      title = prod.css('h3.product_title a').text
      score = prod.css('span.metascore_w').text
      games << {title: title.strip, score: score}
    end
    return games
  end

  # Populate DB with the given games
  def populate_db(games)
    env = ENV['RACK_ENV'] || "development"
    DataMapper::Model.raise_on_save_failure

    DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/#{env}.db")
    DataMapper.finalize
    DataMapper.auto_upgrade!

    games.each do |game|
      # datamapper doesn't seem to support upsert so we'll have to
      # do the check ourselves
      existing_game = Game.first('title' => game[:title])
      if(existing_game)
        existing_game.update('title' => game[:title], 'score' => game[:score])
      else
        Game.create('title' => game[:title], 'score' => game[:score])
      end
    end
  end

  private
  def fetch_html(url)
    page = nil
    begin
      page = Nokogiri::HTML(open(url, 'User-Agent' => 'ruby'))
    rescue OpenURI::HTTPError => e
      puts "There was an error opening the URL #{url}"
      puts e
    end
    return page
  end
end

# Quick dirty test
if __FILE__==$0
  url = "http://www.metacritic.com/browse/games/release-date/available/ps3/metascore?page=1"

  mc_parser = MetaCriticParser.new
  games = mc_parser.parse_top_ps3_games(url)
end
