require './test/test_helper'
require './lib/sequence_generator'

class SequenceGeneratorTest < MiniTest::Test
  def test_it_generates_a_sequence
    seq = SequenceGenerator.random
    assert seq.is_a? Sequence
  end

  def test_it_generates_a_different_sequence
    seq1 = SequenceGenerator.random
    seq2 = SequenceGenerator.random
    refute_equal seq1, seq2 # This could fail.
                            # What if we get the same random results twice?
  end
end
