require_relative 'character'

class Ranger < Character

  def initialize
    super
    @speed = 2
  end

  def appearance
    'R'
  end
end
