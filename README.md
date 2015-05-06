# metacritic
This repo is a coding exercise that consists of 2 parts.
* A parser for parsing the HTML of the “Top Playstation 3 Games (By Metascore)” page (http://www.metacritic.com/game/playstation-3).
* A REST API for retrieving top PS3 games.

## Requirements
* Ruby 1.9.x or greater
* bundler gem installed (needed for dependency management)

## Running tests
* Tests are written as specs and stored under the spec directory.
* Tests can be run as followed
```
rake test
```

## Running the REST API locally
* To run the REST API, first install the required gems via bundle
```
bundle install
```
* Now, run the sinatra app
```
ruby app.rb
```
* You can now access the REST API at localhost:4567/api/v1/games

## Populating the database
To populate the database with the current top PS3 games, run the following Rake task
```
TDB
```
To populate the database with all PS3 games, run the following Rake task
```
TDB
```
