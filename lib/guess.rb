class Guess
  attr_reader :content

  def initialize(string)
    @content = string.chars.map(&:upcase)
  end

  def to_s
    @content.join('')
  end
end
