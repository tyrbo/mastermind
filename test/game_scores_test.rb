require './test/test_helper'
require './lib/game_scores'

class GameScoresTest < MiniTest::Test
  def test_victory_hash_returns_a_proper_hash
    hash = { name: 'Jon', sequence: 'RRRR', time: 20.0 }
    assert_equal hash, GameScores.victory_hash({ sequence: 'RRRR' }, 'Jon', 20.0)
  end

  def test_sort_scores_returns_a_properly_sorted_hash
    json = ['{"name":"Jon","sequence":"BRGG","time":19.969689}', '{"name":"Jon","sequence":"YYGG","time":11.721519}']
    expected = [{'name' => 'Jon', 'sequence' => 'YYGG', 'time' => 11.721519}, {'name' => 'Jon', 'sequence' => 'BRGG', 'time' => 19.969689}]
    assert_equal expected, GameScores.new.sort_scores(json)
  end

  def test_sort_scores_returns_nil_with_bad_json
    json = ['this is some bad json', 'and some more']
    assert_equal nil, GameScores.new.sort_scores(json)
  end
end
