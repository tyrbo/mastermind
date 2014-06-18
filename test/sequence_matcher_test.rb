require './test/test_helper'
require './lib/sequence'
require './lib/guess'
require './lib/sequence_matcher'

class SequenceMatcherTest < MiniTest::Test
  def sequence
    @sequence ||= Sequence.new(['A', 'B', 'C', 'D'])
  end

  def duplicate_sequence
    @duplicate_sequence ||= Sequence.new(['A', 'B', 'A', 'A'])
  end

  def test_has_correct_match_amount
    guess = Guess.new('AAAA')
    sequence = SequenceMatcher.new(guess, Sequence.new(['A', 'B', 'C', 'D']))
    sequence.match?
    assert 1, sequence.matches
  end

  def test_has_a_character
    guess1 = Guess.new('ABCD')
    assert SequenceMatcher.new(guess1, sequence).include?('A')
  end

  def test_has_multiple_characters
    guess1 = Guess.new('AAAB')
    sequence = SequenceMatcher.new(guess1, duplicate_sequence)

    assert sequence.include?('A')
    assert sequence.include?('A')
    assert sequence.include?('A')
    refute sequence.include?('A')
  end

  def test_has_no_character
    guess1 = Guess.new('ABCD')
    refute SequenceMatcher.new(guess1, sequence).include?('Z')
  end

  def test_has_a_position
    guess1 = Guess.new('ABCD')
    assert SequenceMatcher.new(guess1, sequence).position?('B', 1)
  end

  def test_has_no_position
    guess1 = Guess.new('ABCD')
    refute SequenceMatcher.new(guess1, sequence).position?('F', 1)
  end
end
