require './test/test_helper'
require './lib/guess'

class GuessTest < MiniTest::Test
  def test_it_has_content
    guess = Guess.new('ABCD')
    assert guess.content
  end

  def test_content_is_an_array
    guess = Guess.new('ABCD')
    assert guess.content.is_a? Array
  end

  def test_it_upcases_letters
    guess = Guess.new('abcd')
    assert_equal ['A', 'B', 'C', 'D'], guess.content
  end

  def test_it_responds_to_to_s
    guess = Guess.new('abcd')
    assert_equal 'ABCD', guess.to_s
  end
end
