require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a[rand(0..25)] }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @score = check_dictionary(@word) && check_letters(@word, @letters) ? @word.length : 0
  end

  private

  def check_dictionary(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = JSON.parse(open(url).read)
    response['found']
  end

  def check_letters(word, letters)
    word.upcase!
    word.split('').all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
