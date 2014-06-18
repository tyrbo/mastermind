require './lib/game'

class REPL
  attr_reader :running, :playing

  def initialize
    @running = false
    @playing = false
  end

  def run
    @running = true

    while running
      input = get_input
    end
  end
end
