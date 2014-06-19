require './test/test_helper'
require './lib/sequence'

class SequenceTest < MiniTest::Test
  def sequence
    @sequence ||= Sequence.new(['A', 'B', 'C', 'D'])
  end
  def test_it_has_a_secret_sequence
    assert sequence.secret_sequence
  end

  def test_comparing_two_sequences
    s2 = sequence.dup
    s3 = Sequence.new(['D', 'B', 'C', 'A'])

    assert sequence == s2
    refute sequence == s3
  end

  def test_it_responds_with_count
    assert_equal 4, sequence.count
  end

  def test_it_responds_to_to_s
    assert_equal 'ABCD', sequence.to_s
  end

  def test_it_responds_to_indexes
    assert_equal 'A', sequence[0]
  end
end
