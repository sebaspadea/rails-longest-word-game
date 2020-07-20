require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a
    @letters = @letters.sample(10)
    @letters
  end
  
  def score
    word = params[:word]
    letters = params[:letters].split(" ")
    if validation_grid?(word, letters)
      if validation_word?(word)
        @resultado = "Congratulations! #{word.upcase} is a valid English word!"
      else
        @resultado = "Sorry but #{word.upcase} does not seem to be a valid English word..."
      end
    else
      @resultado = "Sorry but #{params[:word].upcase} can´t build out of #{letters}"
    end
  end

  def validation_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    word_json = JSON.parse(user_serialized)
    word_json["found"]
  end

  def validation_grid?(word, letters)
    word = word.upcase.chars
    word.all? { |char| word.count(char) <= letters.count(char) }
  end
end
