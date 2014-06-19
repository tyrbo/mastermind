class Command
  attr_reader :command

  def initialize(command)
    @command = command.downcase
  end

  def is_quit
    ['q', 'quit'].include?(command)
  end

  def is_commands
    ['c', 'commands'].include?(command)
  end

  def is_instructions
    ['i', 'instructions'].include?(command)
  end

  def is_play
    ['p', 'play'].include?(command)
  end

  def is_guess
    ['g', 'guess'].include?(command)
  end

  def is_history
    ['h', 'history'].include?(command)
  end
end
