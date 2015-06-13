class Character
  attr_reader :attack, :speed
  attr_accessor :defense

  def initialize
    @attack = 1
    @defense = 1
    @speed = 1
  end

  def alive?
    @defense > 0
  end
end
