class SequenceMatcher
  attr_reader :guess, :sequence

  def initialize(guess, sequence)
    @guess = guess
    @sequence = sequence
    @matches = @positions = 0
  end

  def match?
    guess.content.each_with_index do |char, idx|
      @matches += 1 if has?(char)
      @positions += 1 if sequence[idx] == char
    end
    match_hash
  end

  private

  def has?(char)
    if temp_sequence.include?(char)
      temp_sequence.delete_at(temp_sequence.find_index(char))
      true
    end
  end

  def match_hash
    full_match = (@matches == sequence.count) && (@positions == sequence.count)
    { matches: @matches, positions: @positions, full_match: full_match }
  end

  def temp_sequence
    @temp_sequence ||= sequence.secret_sequence.dup
  end
end
