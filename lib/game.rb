require './lib/errors'
require './lib/guess_validator'
require './lib/guess'
require './lib/sequence_generator'
require './lib/sequence_matcher'

class Game
  attr_reader :guesses, :sequence

  def initialize
    @guesses = []
  end

  def start
    raise GameAlreadyStarted if @sequence
    @sequence = SequenceGenerator.new.random
  end

  def guess(guess)
    raise GameNotStarted if !@sequence
    if GuessValidator.valid?(guess)
      guess = Guess.new(guess)
      @guesses << guess
      SequenceMatcher.new(guess, @sequence).match?
    end
  end
end
