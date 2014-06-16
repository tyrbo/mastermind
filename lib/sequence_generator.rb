require './lib/sequence'

class SequenceGenerator
  def self.random
    options = ['R', 'G', 'B', 'Y']
    Sequence.new(options.sample(4))
  end
end
