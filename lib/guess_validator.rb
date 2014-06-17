class GuessValidator
  def self.valid?(guess)
    guess.to_s.upcase =~ /^[RGBY]{4}$/
  end
end
