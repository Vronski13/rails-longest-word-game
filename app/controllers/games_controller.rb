require 'json'
require 'open-uri'

class GamesController < ApplicationController
  ALPHABET = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

  def new
    @letters = ALPHABET.sample(10)
  end

  def score
    @input = params[:input]
    @grid = params[:grid]

    url = "http://wagon-dictionary.herokuapp.com/#{@input}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)

    @input_array = @input.split('').sort
    @letters_array = @grid.split(' ').sort

    if word['found'] == false
      @answer = 'Sorry this is not an English word'
    elsif word['length'] >= 10
      @answer = "Sorry but #{@input} can't be built out of #{@grid}"
    elsif
      array = @letters_array.select { |letter| letter =~ @input_array[0..(@input_array.length - 1)]}
      raise
      if @input_array == array
        @answer = 'Congratulations'
      else
        @answer = "Sorry but #{@input} can't be built out of #{@grid}"
        raise
      end
    end
  @answer
  end


end

