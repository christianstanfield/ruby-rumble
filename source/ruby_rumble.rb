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

    @players = [{ character: characters.pop,
                  position: 0,
                  direction: 'left' },
                { character: characters.pop,
                  position: @length - 1,
                  direction: 'right' }]
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
    board = Array.new(@length - @players.length) { ' ' }

    @players.each do |player|
      board.insert player[:position], player[:character].appearance
    end

    puts 'Ruby Rumble!!!'
    puts '*' * @length
    remaining_board = @length - @player_name.length - 'Enemy'.length
    puts "#{@player_name}" + ' ' * remaining_board + 'Enemy'
    puts ''
    puts board.join
  end

  def move_characters(player, opponent)

    case player[:direction]
    when 'left'
      player[:position] += player[:character].speed
      player[:position] = opponent[:position] - 1 if player[:position] >= opponent[:position]
    when 'right'
      player[:position] -= player[:character].speed
      player[:position] = opponent[:position] + 1 if player[:position] <= opponent[:position]
    end
  end

  def attack_characters(player, opponent)

    if (player[:position] - opponent[:position]).abs == 1
      opponent[:character].defense -= player[:character].attack
    end
  end

  def finished?
    # returns true when one player's characters are all defeated
    # returns false otherwise
    @players.map { |player| player[:character].alive? }.include? false
  end

  def winner
    # returns the name of the winning character
    winner = @players.find { |player| player[:character].alive? }
    winner[:character].class
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
