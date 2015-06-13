require_relative 'character'

class Knight < Character

  def initialize
    super
    @attack = 2
  end

  def appearance
    'K'
  end
end
