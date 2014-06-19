require './lib/game'
require './lib/repl_printer'
require './lib/time_tracker'
require './lib/game_scores'
require 'json'

class REPL
  attr_reader :running, :playing, :game, :printer, :last_result

  def initialize
    @running = false
    @playing = false
    @game = nil
    @printer = REPLPrinter.new(self)
  end

  def run
    @running = true

    printer.intro
    printer.commands
    run_loop
    printer.outro
  end

  private

  def run_loop
    while running
      input, args = get_input
      process(input, args)
    end
  end

  def get_input
    print '> '
    gets.strip.split
  end

  def process(command, args)
    if      command == 'q' then quit
    elsif   command == 'c' then printer.print_commands
    elsif   command == 'i' then printer.print_instructions
    elsif !playing
      if    command == 'p' then play
      end
    elsif playing
      if    command == 'g' then guess(args)
      elsif command == 'h' then printer.history(game.guesses)
      end
    end
  end
  
  def play
    init_game
    printer.commands
  end
  
  def init_game
    @playing = true
    @last_result = nil
    @game = Game.new
    time_tracker.start
    game.start
  end
  
  def time_tracker
    @time_tracker ||= TimeTracker.new
  end
  
  def guess(args)
    @last_result = game.guess(args)
    check_guess_hash
  end

  def check_guess_hash
    if last_result.is_a? Hash
      handle_hash
    else
      puts last_result
    end
  end

  def handle_hash
    if last_result[:full_match]
      handle_win
    else
      handle_guess
    end
  end

  def handle_win
    time_tracker.stop
    printer.winner(last_result, game.guesses.count, calculate_time)
    save_record
    print_records
    quit
  end

  def calculate_time
    time_tracker.difference_in_words
  end

  def save_record
    print 'Enter your name to save score: '
    name = gets.strip
    if !name.empty?
      GameScores.save(last_result, name, time_tracker.difference)
    end
  end

  def print_records
    scores = GameScores.new.prepare
    printer.top_scores(scores)
  end

  def handle_guess
    printer.guess_hint(last_result, game.guesses.count)
  end

  def quit
    if playing
      printer.quit_game
      @playing = false
    else
      @running = false
    end
  end
end
