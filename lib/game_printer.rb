class GamePrinter
  def self.output_guess(hash, guesses)
    sequence = hash[:sequence]
    guess = hash[:guess]
    guess_phrase = pluralize(guesses)
    if hash[:full_match]
      "Congratulations! You guessed the sequence '#{sequence.to_s}' in #{guess_phrase}."
    else
      "'#{guess.to_s}' has #{hash[:matches]} of the correct elements with #{hash[:positions]} in the correct position.\nYou've taken #{guess_phrase}."
    end
  end

  def self.pluralize(guesses)
    if guesses > 1
      "#{guesses} guesses"
    else
      "#{guesses} guess"
    end
  end
end
