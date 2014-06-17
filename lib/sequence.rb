class Sequence
  attr_reader :secret_sequence

  def initialize(sequence)
    @secret_sequence = sequence
  end

  def ==(other)
    secret_sequence == other.secret_sequence
  end

  def [](idx)
    @secret_sequence[idx]
  end

  def count
    @secret_sequence.count
  end

  def to_s
    @secret_sequence.join('')
  end
end
