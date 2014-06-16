class Guess
  attr_reader :content

  def initialize(string)
    @content = string.chars.map(&:upcase)
  end
end
