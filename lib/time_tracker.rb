require './lib/pluralizer'

class TimeTracker
  attr_accessor :difference, :start_time, :stop_time

  def initialize
    @start_time = 0
    @stop_time = 0
  end

  def start
    @start_time = Time.now
  end

  def stop
    @stop_time = Time.now
    @difference = @stop_time - @start_time
  end

  def difference_in_words 
    minutes = (difference / 60.0).floor
    seconds = (difference % 60).floor
    time_in_words_string(minutes, seconds)
  end

  private

  def time_in_words_string(minutes, seconds)
    arr = []
    arr << Pluralizer.pluralize(minutes, 'minute') if minutes > 0
    arr << Pluralizer.pluralize(seconds, 'second')
    arr.join(', ')
  end
end
