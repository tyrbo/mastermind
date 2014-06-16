require './test/test_helper'
require './lib/game_printer'
require './lib/sequence'
require './lib/guess'

class GamePrinterTest < MiniTest::Test
  def correct_hash
    @correct_hash ||= { 
      matches: 4,
      positions: 4,
      full_match: true,
      sequence: Sequence.new(['A', 'B', 'C', 'D']),
      guess: Guess.new('ABCD')
    }
  end

  def incorrect_hash
    @incorrect_hash ||= { 
      matches: 4,
      positions: 2,
      full_match: false,
      sequence: Sequence.new(['A', 'B', 'C', 'D']),
      guess: Guess.new('ACBD')
    }
  end

  def correct_match
    "Congratulations! You guessed the sequence 'ABCD'."
  end

  def incorrect_match
    "'ACBD' has 4 of the correct elements with 2 in the correct position."
  end

  def test_output_guess_with_full_match
    assert_equal correct_match, GamePrinter.output_guess(correct_hash)
  end

  def test_output_guess_with_incorrect_match
    assert_equal incorrect_match, GamePrinter.output_guess(incorrect_hash)
  end
end
