class Sequence
  attr_reader :secret_sequence

  def initialize(sequence)
    @secret_sequence = sequence
  end

  def ==(other)
    secret_sequence == other.secret_sequence
  end
end
