require './lib/sequence'

class SequenceGenerator
  attr_reader :options

  def initialize
    @options = ['R', 'G', 'B', 'Y']
    @arr = []
  end

  def random
    Sequence.new(populate)
  end

  private

  def populate
   (0...4).collect { @options.sample }
   # while @arr.length < 4
   #   @arr << options[rand(options.length)]
   # end
   # @arr
  end
end
