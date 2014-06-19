require 'rainbow/ext/string'

class REPLPrinter
  attr_reader :obj

  def initialize(obj)
    @obj = obj
  end

  def intro
    ascii
    puts 'Welcome to Mastermind CLI.'
  end

  def commands
    if obj.playing
      puts 'You may (g)uess the sequence, view your guessing (h)istory, read the (i)nstructions, reprint this list of (c)ommands, or (q)uit.'
    else
      puts 'You may (p)lay the game, read the (i)nstructions, reprint this list of (c)ommands, or (q)uit.'
    end
  end

  def instructions
    puts "Mastermind is a sequence guessing game."
    puts "I will generate a sequence of four elements made up of: (R)ed, (G)reen, (B)lue, and (Y)ellow."
    puts "The goal is to (g)uess the generated sequence in as few moves as possible."
  end

  def history(guesses)
    guesses.each_with_index do |guess, index|
      puts "#{index + 1}. #{guess[:guess]}, #{guess[:matches]} matches and #{guess[:positions]} positions."
    end
  end

  def guess_hint(result, guesses)
    puts "Your guess '#{result[:guess]}' contains #{result[:matches]} correct elements in #{result[:positions]} correct positions."
    puts "You've taken #{Pluralizer.pluralize(guesses, 'guess', 'guesses')}."
  end

  def winner(result, guesses, time)
    puts "Congratulations, you guessed the sequence '#{result[:sequence]}' in #{Pluralizer.pluralize(guesses, 'guess', 'guesses')} over #{time}."
  end

  def top_scores(scores)
    puts '', '=== TOP 10 ==='
    scores.each_with_index do |score, index|
      top_score(score, index)
    end
    puts
  end

  def top_score(score, index)
    puts "#{index + 1}. #{score['name']} correctly guessed '#{score['sequence']}' in #{score['time']}."
  end

  def quit_game
    puts 'Thank you for playing Mastermind.'
    puts 'Would you like to (p)lay again?'
  end

  def outro
    puts 'Good bye.'
  end

  def ascii
    puts
    puts (' __  __           _                      _           _').color(:red)
    puts ('|  \/  | __ _ ___| |_ ___ _ __ _ __ ___ (_)_ __   __| |').color(:yellow)
    puts ('| |\/| |/ _` / __| __/ _ \ \'__| \'_ ` _ \| | \'_ \ / _` |').color(:green)
    puts ('| |  | | (_| \__ \ ||  __/ |  | | | | | | | | | | (_| |').color(:blue)
    puts ('|_|  |_|\__,_|___/\__\___|_|  |_| |_| |_|_|_| |_|\__,_|').color(:magenta)
    puts
  end
end
