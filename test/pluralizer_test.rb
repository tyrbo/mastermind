require './test/test_helper'
require './lib/pluralizer'

class PluralizerTest < MiniTest::Test
  def test_it_pluralizes
    str = Pluralizer.pluralize(2, 'cat')
    assert_equal '2 cats', str
  end

  def test_it_doesnt_pluralize_singles
    str = Pluralizer.pluralize(1, 'cat')
    assert_equal '1 cat', str
  end

  def test_it_pluralizes_with_custom_plural
    str = Pluralizer.pluralize(4, 'person', 'people')
    assert_equal '4 people', str
  end
end
