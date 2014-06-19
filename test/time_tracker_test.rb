require './test/test_helper'
require './lib/time_tracker'

class TimeTrackerTest < MiniTest::Test
  def test_it_can_be_started
    t = TimeTracker.new
    assert_equal 0, t.start_time
    t.start
    refute_equal 0, t.start_time
  end
  
  def test_it_can_be_stopped
    t = TimeTracker.new
    assert_equal 0, t.stop_time
    t.start
    t.stop
    refute_equal 0, t.stop_time
  end

  def test_it_has_a_difference
    t = TimeTracker.new
    refute t.difference
    t.start
    t.stop
    assert_equal (t.stop_time - t.start_time), t.difference
  end

  def test_it_converts_time_to_words
    t = TimeTracker.new
    t.difference = 50
    assert_equal '50 seconds', t.difference_in_words
    t.difference = 61
    assert_equal '1 minute, 1 second', t.difference_in_words
    t.difference = 311
    assert_equal '5 minutes, 11 seconds', t.difference_in_words
  end
end
