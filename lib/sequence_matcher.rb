require './lib/game_printer'

class SequenceMatcher
  attr_reader :guess, :sequence

  def initialize(guess, sequence)
    @guess = guess
    @sequence = sequence
    @matches = @positions = 0
  end

  def match?
    guess.content.each_with_index do |char, idx|
      @matches += 1 if include?(char)
      @positions += 1 if position?(char, idx)
    end
    match_hash
  end

  def include?(char)
    if temp_sequence.include?(char)
      temp_sequence.delete_at(temp_sequence.find_index(char))
      true
    end
  end

  def position?(char, idx)
    sequence[idx] == char
  end

  def match_hash
    count = sequence.count
    full_match = (@matches == count) && (@positions == count)
    { matches: @matches, positions: @positions, full_match: full_match, sequence: sequence, guess: @guess }
  end

  private

  def temp_sequence
    @temp_sequence ||= sequence.secret_sequence.dup
  end
end
