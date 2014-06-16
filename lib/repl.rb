require './lib/game'

class REPL
  def run
    game = Game.new
    game.start
    still_playing = true

    while still_playing
      print '> '
      input = gets.strip
      puts game.guess(input)
    end
  end
end

REPL.new.run
