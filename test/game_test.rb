require './test/test_helper.rb'
require './lib/game.rb'

class GameTest < MiniTest::Test
  def test_a_game_starts_with_zero_guesses
    g = Game.new
    assert_equal 0, g.guesses.count
  end

  def test_add_a_guess
    g = Game.new
    g.start
    g.guess('RGBY')
    assert_equal 1, g.guesses.count
  end
  
  def test_only_valid_guesses_are_added
    g = Game.new
    g.start

    g.guess(nil)
    assert_equal 0, g.guesses.count

    g.guess('RRRR')
    assert_equal 1, g.guesses.count
  end

  def test_cant_guess_if_game_isnt_started
    g = Game.new
    assert_raises(GameNotStarted) { g.guess('RGBY') }
  end

  def test_starting_a_game_should_generate_a_new_sequence
    g = Game.new
    g.start
    assert g.sequence
  end

  def test_starting_another_game_should_raise_exception
    g = Game.new
    g.start
    assert_raises(GameAlreadyStarted) { g.start }
  end
end
