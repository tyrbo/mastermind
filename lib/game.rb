require './lib/errors'
require './lib/guess_validator'
require './lib/guess'
require './lib/sequence_generator'
require './lib/sequence_matcher'

class Game
  attr_reader :guesses, :sequence

  def initialize
    @guesses = []
    @started = false
    @sequence = SequenceGenerator.new.random
  end

  def start
    raise GameAlreadyStarted if @started
    @started = true
  end

  def guess(guess)
    raise GameNotStarted unless @started
    if GuessValidator.valid?(guess)
      process_guess(guess)
    else
      'You must enter a valid guess.'
    end
  end

  private

  def process_guess(guess)
    guess = Guess.new(guess)
    match_data = SequenceMatcher.new(guess, @sequence).match?
    @guesses << match_data
    match_data
  end
end
