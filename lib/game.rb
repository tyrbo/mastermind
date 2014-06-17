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
      process_guess(guess)
    else
      'You must enter a valid guess.'
    end
  end

  private

  def process_guess(guess)
    guess = Guess.new(guess)
    @guesses << guess
    result = SequenceMatcher.new(guess, @sequence).match?
    GamePrinter.output_guess(result, guesses.count)
  end
end
