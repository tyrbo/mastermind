require 'json'

class GameScores
  def self.save(result, name, time)
    File.open('scores.json', 'a') do |f|
      f.puts victory_hash(result, name, time).to_json
    end
  end

  def self.victory_hash(result, name, time)
    { name: name, sequence: result[:sequence].to_s, time: time }
  end

  def prepare
    if File.file?('scores.json')
      scores = sort_scores(File.readlines('scores.json'))[0...10] || []
      scores.map { |score| calculate_time(score) }
    end
  end

  def calculate_time(score)
    t = TimeTracker.new
    t.difference = score['time']
    score['time'] = t.difference_in_words
    score
  end
  
  def sort_scores(scores)
    scores.map { |score|
      JSON.parse(score)
    }.sort_by { |score| score['time'].to_f }
  rescue JSON::ParserError
    nil
  end
end
