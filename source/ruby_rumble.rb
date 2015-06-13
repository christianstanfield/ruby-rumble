require_relative 'knight'
require_relative 'mage'
require_relative 'ranger'

class RubyRumble

  def initialize
    @length = 30
    # fill me in!

    @players = []
    @players.shuffle!
  end

  def run
    reset_screen!
    welcome_screen
    @player_name = gets.chomp
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
    puts "Welcome #{@player_name}!"
    puts ''
    puts 'Are you ready to rumble?'
  end

  def rumble

    until finished?
      @players.each_with_index do |player, index|
        print_board
        move_characters(player, @players[index - 1])
        attack_characters(player, @players[index - 1])
        sleep(0.3) # http://ruby-doc.org/core-2.2.2/Kernel.html#method-i-sleep
      end
    end

    print_board
    puts ''
    puts "#{winner} has won!"
  end

  def print_board
    reset_screen!
    board = # ?

    puts 'Ruby Rumble!!!'
    puts '*' * @length
    remaining_board = @length - @player_name.length - 'Enemy'.length
    puts "#{@player_name}" + ' ' * remaining_board + 'Enemy'
    puts ''
    puts board
  end

  def move_characters(player, opponent)

  end

  def attack_characters(player, opponent)

  end

  def finished?
    # returns true when one player's characters are all defeated
    # returns false otherwise
  end

  def winner
    # returns the name of the winning character
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
