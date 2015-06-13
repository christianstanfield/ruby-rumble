require_relative 'knight'
require_relative 'mage'
require_relative 'ranger'

class RubyRumble

  def initialize
    @length = 30
    knight = Knight.new
    mage = Mage.new
    ranger = Ranger.new
    characters = [knight, mage, ranger].shuffle

    @players_character = characters.pop
    @enemy_character = characters.pop
    @player_positions = [[@players_character, 0],
                         [@enemy_character, @length - 1]]
  end

  def run
    reset_screen!
    welcome_screen
    @player = gets.chomp
    welcome_player
    ready = gets.chomp.downcase
    rumble if ready == 'yes'
  end

  def welcome_screen
    puts '*' * 30
    puts 'Welcome to Ruby Rumble!!!'
    puts <<-eos
               ____
           _ .'   .`'.
          | |  -.  :  |
          |_| ,__) :  |
             \___  _.'
         _ .'    `'.
        | |         |
        |_|         |
           '._____.'

    eos
    puts 'What is your name?'
  end

  def welcome_player
    puts ''
    puts "Welcome #{@player}!"
    puts ''
    puts 'Are you ready to rumble?'
  end

  def rumble
    turn = 0

    until finished?
      # players.each do |player|
      print_board
      move_characters(turn)
      sleep(0.5) # http://ruby-doc.org/core-2.2.2/Kernel.html#method-i-sleep
      turn += 1
      turn = 0 if turn == @player_positions.length
    end

    print_board
    puts ''
    puts "#{winner} has won!"
  end

  def print_board
    reset_screen!
    board = Array.new(@length - @player_positions.length) { ' ' }

    @player_positions.each do |player|
      board.insert player[1], player[0].appearance
    end

    puts '*' * @length
    remaining_board = @length - @player.length - 'Enemy'.length
    puts "#{@player}" + ' ' * remaining_board + 'Enemy'
    puts ''
    puts board.join
  end

  def move_characters(turn)
    player = @player_positions[turn]
    if turn == 0
      player[1] += player[0].speed
    else
      player[1] -= player[0].speed
    end

    if @player_positions[0][1] >= @player_positions[1][1]
      @player_positions[0][1] = @player_positions[1][1] - 1
      attack_characters(turn)
    end

    if @player_positions[1][1] <= @player_positions[0][1]
      @player_positions[1][1] = @player_positions[0][1] + 1
      attack_characters(turn)
    end
  end

  def attack_characters(turn)
    if turn == 0
      @player_positions[1][0].defense -= @player_positions[0][0].attack
    else
      @player_positions[0][0].defense -= @player_positions[1][0].attack
    end
  end

  def finished?
    # returns true when one player's characters are all defeated
    # returns false otherwise
    fin = @player_positions.map { |player| player[0].alive? }
    fin.include? false
  end

  def winner
    # returns the winner if there is one, nil otherwise
    if @players_character.alive?
      return @player
    else
      return 'Enemy'
    end
  end

  def reset_screen!
    clear_screen!
    move_to_home!
  end

  private

  def clear_screen!
    print "\e[2J" # clears the screen
  end

  def move_to_home!
    print "\e[H" # moves the cursor back to the upper left
  end
end
