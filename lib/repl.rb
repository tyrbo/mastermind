require './lib/game'
require 'json'

class REPL
  attr_reader :running, :playing, :game, :start_time, :time

  def initialize
    @running = false
    @playing = false
    @game = nil
    @time = nil
  end

  def run
    @running = true

    print_intro
    print_commands
    run_loop
    print_outro
  end

  private

  def print_intro
    puts 'Welcome to Mastermind CLI.'
  end

  def print_commands
    if playing
      puts 'You may (g)uess the sequence, read the (i)nstructions, reprint the list of (c)ommands, or (q)uit.'
    else
      puts 'You may (p)lay the game, read the (i)nstructions, reprint the list of (c)ommands, or (q)uit.'
    end
  end

  def print_instructions
    puts "Mastermind is a sequence guessing game."
    puts "I will generate a sequence of four elements made up of: (R)ed, (G)reen, (B)lue, and (Y)ellow."
    puts "The goal is to (g)uess the generated sequence in as few moves as possible."
    puts
  end

  def run_loop
    while running
      input, args = get_input
      process(input, args)
    end
  end

  def print_outro
    puts 'Good bye.'
  end

  def get_input
    print '> '
    gets.strip.split
  end

  def process(command, args)
    if    command == 'q' then quit
    elsif command == 'c' then print_commands
    elsif command == 'i' then print_instructions
    elsif !playing
      if command == 'p' then play
      end
    elsif playing
      if command == 'g' then guess(args)
      end
    end
  end

  def play
    @playing = true
    @game = Game.new
    @start_time = Time.now
    game.start
    puts "I've generated a sequence. Let's play!"
    print_commands
  end

  def guess(args)
    check_guess_hash(game.guess(args))
  end

  def check_guess_hash(result)
    if result.is_a? Hash
      handle_hash(result)
    else
      puts result
    end
  end

  def handle_hash(result)
    if result[:full_match]
      handle_win(result)
    else
      handle_guess(result)
    end
  end

  def handle_win(result)
    @time = Time.now - start_time
    puts "Congratulations, you guessed the sequence '#{result[:sequence]}' in #{pluralize(game.guesses.count)} over #{calculate_time}."
    save_record(result)
    print_records
    quit
  end

  def save_record(result)
    print 'Enter your name to save score: '
    name = gets.strip
    if !name.empty?
      File.open('scores.json', 'a') do |f|
        f.puts victory_hash(result, name).to_json
      end
    end
  end

  def print_records
    if File.file?('scores.json')
      scores = sort_scores(File.readlines('scores.json'))[0...10]
      puts '=== TOP 10 ==='
      scores.each_with_index do |score, index|
        handle_score(score, index)
      end
    end
  end

  def sort_scores(scores)
    scores.map { |score|
      JSON.parse(score)
    }.sort_by { |score| score['time'].to_i }
  rescue
    puts 'Uh oh! The scores.json file contains a malformed entry.'
  end

  def handle_score(score, index)
    calculated_time = calculate_time(score['time'])
    puts "#{index + 1}. #{score['name']} correctly guessed '#{score['sequence']}' in #{calculate_time(score['time'])}."
  end

  def victory_hash(result, name)
    { name: name, sequence: result[:sequence].to_s, time: time }
  end

  def handle_guess(result)
    puts "Your guess '#{result[:guess]}' contains #{result[:matches]} correct elements in #{result[:positions]} correct positions."
    puts "You've taken #{pluralize(game.guesses.count)}."
  end

  def pluralize(number, plurals = ['guess', 'guesses'])
    if number == 1
      "#{number} #{plurals.first}"
    else
      "#{number} #{plurals.last}"
    end
  end

  def calculate_time(time_in_seconds = time)
    minutes = (time_in_seconds / 60.0).round
    seconds = (time_in_seconds % 60).round
    "#{pluralize(minutes, ['minute', 'minutes'])}, #{pluralize(seconds, ['second', 'seconds'])}"
  end

  def quit
    if playing
      puts 'Thank you for playing Mastermind.'
      puts 'Would you like to (p)lay again?'
      @playing = false
    else
      @running = false
    end
  end
end
