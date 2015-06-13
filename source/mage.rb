require_relative 'character'

class Mage < Character

  def initialize
    super
    @defense = 2
  end

  def appearance
    'M'
  end
end
