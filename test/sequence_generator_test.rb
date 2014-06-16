require './test/test_helper'
require './lib/sequence_generator'

class SequenceGeneratorTest < MiniTest::Test
  def test_it_generates_a_sequence
    seq = SequenceGenerator.new.random
    assert seq.is_a? Sequence
  end
end
