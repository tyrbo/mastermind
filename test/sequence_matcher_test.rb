require './test/test_helper'
require './lib/sequence'
require './lib/guess'
require './lib/sequence_matcher'

class SequenceMatcherTest < MiniTest::Test
  def sequence
    @sequence ||= Sequence.new(['A', 'B', 'C', 'D'])
  end

  def test_for_a_valid_match
    guess1 = Guess.new('ABCD')
    result = SequenceMatcher.new(guess1, sequence).match?
    assert_equal 4, result[:matches]
    assert_equal 4, result[:positions]
    assert result[:full_match]
  end

  def test_for_a_partial_match
    result = SequenceMatcher.new(Guess.new('ACBA'), sequence).match?
    assert_equal 3, result[:matches]
    assert_equal 1, result[:positions]
    refute result[:full_match]
  end

  def test_multiple_repeats_dont_break_things
    result = SequenceMatcher.new(Guess.new('ABAB'), Sequence.new(['A', 'A', 'A', 'A'])).match?
    assert_equal 2, result[:matches]
    assert_equal 2, result[:positions]
  end

  def test_for_no_matches
    result = SequenceMatcher.new(Guess.new('ZZZZ'), sequence).match?
    assert_equal 0, result[:matches]
    assert_equal 0, result[:positions]
    refute result[:full_match]
  end
end
