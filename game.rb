require_relative 'card'
require_relative 'сard_deck'
require_relative 'dealer'
require_relative 'player'


class Game
  attr_reader :player, :dealer, :deck

  def initialize
    puts 'Введите ваше имя'
    @player = Player.new(gets.chomp)
    @dealer = Player.new('Dealer')
    @deck = Deck.new
  end



  def player_turn
    # Логика хода игрока
  end

  def dealer_turn
    # Логика хода дилера
  end

  def determine_winner
    # Логика определения победителя
  end
end
