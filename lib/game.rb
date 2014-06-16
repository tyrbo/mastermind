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
    @sequence = SequenceGenerator.random
  end

  def guess(guess)
    raise GameNotStarted if !@sequence
    if GuessValidator.valid?(guess)
      guess = Guess.new(guess)
      SequenceMatcher.match?(guess, @sequence)
      @guesses << guess
    end
  end
end
