class Pluralizer
  def self.pluralize(number, singular, plural = nil)
    if number == 1
      "#{number} #{singular}"
    elsif plural
      "#{number} #{plural}"
    else
      "#{number} #{singular}s"
    end
  end
end
