class GamePrinter
  def self.output_guess(hash)
    sequence = hash[:sequence]
    guess = hash[:guess]
    if hash[:full_match]
      "Congratulations! You guessed the sequence '#{sequence.to_s}'."
    else
      "'#{guess.to_s}' has #{hash[:matches]} of the correct elements with #{hash[:positions]} in the correct position."
    end
  end
end
