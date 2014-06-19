require './lib/game'
require 'dispel'

class REPL
  attr_reader :running, :playing, :game, :start_time

  def initialize
    @running = false
    @playing = false
    @game = nil
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
    game.start
    @start_time = Time.now
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
    puts "Congratulations, you guessed the sequence '#{result[:sequence]}' in #{pluralize(game.guesses.count)}."
    puts "You finished in #{calculate_time}."
    quit
  end

  def handle_guess(result)
    puts "Your guess '#{result[:guess]}' contains #{result[:matches]} correct elements in #{result[:positions]} correct positions."
  end

  def pluralize(number, plurals = ['guess', 'guesses'])
    if number == 1
      "#{number} #{plurals.first}"
    else
      "#{number} #{plurals.last}"
    end
  end

  def calculate_time
    difference = Time.now - @start_time
    minutes = (difference / 60.0).round
    seconds = (difference % 60).round
    "#{pluralize(minutes, ['minute', 'minutes'])}, #{pluralize(seconds, ['second', 'seconds'])}"
  end

  def quit
    if playing
      puts 'Thank you for playing Mastermind.'
      @playing = false
    else
      @running = false
    end
  end
end
