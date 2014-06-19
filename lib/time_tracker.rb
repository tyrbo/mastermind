class TimeTracker
  attr_accessor :difference

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
    minutes = (difference / 60.0).round
    seconds = (difference % 60).round
    "#{Pluralizer.pluralize(minutes, 'minute')}, #{Pluralizer.pluralize(seconds, 'second')}"
  end
end
