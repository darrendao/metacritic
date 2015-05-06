# metacritic
[![Build Status](https://travis-ci.org/darrendao/metacritic.svg?branch=master)](https://travis-ci.org/darrendao/metacritic)

This repo is a coding exercise that consists of 2 parts.
* A parser for parsing the “Top Playstation 3 Games (By Metascore)” page (http://www.metacritic.com/game/playstation-3). This is written in Ruby.
* A REST API for retrieving top PS3 games. This is written as a Sinatra web app. For development and demo purposes, this web app is backed by a sqlite DB.

## Requirements
* Ruby 1.9.x or greater (tested with 1.9.3-p429 and 2.0.0-p353). Refer to rbenv or RVM for managing your Ruby installations.
* bundler gem installed (needed for dependency management)
```
sudo gem install bundler
```
* Install native dev packages for ruby, sqlite, libxslt and libxml2. For example, on Centos, you can run
```
sudo yum install ruby-devel
sudo yum groupinstall 'Development Tools'
sudo yum install sqlite-devel
sudo yum install libxml2-devel libxslt-devel
```
* On Ubuntu, you can run
```
sudo apt-get install build-essential
sudo apt-get install ruby-dev
sudo apt-get install libsqlite3-dev
sudo apt-get install libxslt-dev libxml2-dev
```
* Install all Ruby gems dependency
```
bundle install
```
## Running tests
* Tests are written as specs and stored under the spec directory.
* Tests can be run as followed
```
RACK_ENV=test rake test
```
## Parsing the “Top Playstation 3 Games (By Metascore)” page
* You can either use the following Rake task
```
rake parse:top_ps3_games 
```
* Or you can invoke the parser directly
```
./parser top_games
```
## Running the REST API
* To start the REST API, simply run the Sinatra app
```
ruby app.rb
```
* You can now access the REST API at [localhost:4567/api/v1/games](http://localhost:4567/api/v1/games)

## Populating the database
To populate the database with the current top PS3 games, run the following Rake task
```
rake db:populate_top_ps3_games
```
For fun, you can also populate the DB with additional list of PS3 games by running
```
rake db:populate_sample_ps3_games
```
## Using the REST API
* To view all games, make a GET request to /api/v1/games
* To view a particular game, make a GET request to /api/v1/games/GAME_TITLE_GOES_IN_HERE

## Deploying to production
* I would recommend running the Sinatra web app on Puma behind nginx.
* For database, I would recommend using MongoDB.
