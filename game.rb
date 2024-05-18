# frozen_string_literal: true

require_relative 'card_deck'
require_relative 'player'
require_relative 'dealer'

class Game
  BET_AMOUNT = 10

  def initialize
    @deck = Deck.new
    @player = Player.new(ask_player_name)
    @dealer = Dealer.new
  end

  def play
    loop do
      setup_round
      player_turn
      dealer_turn unless @player_opened_cards
      reveal_cards
      settle_bets
      break unless play_again?
    end
  end

  private

  def ask_player_name
    puts 'Введите ваше имя:'
    gets.chomp
  end

  def setup_round
    @player.reset_hand
    @dealer.reset_hand
    2.times do
      @player.hand.add_card(@deck.draw)
      @dealer.hand.add_card(@deck.draw)
    end
    @player.bet(BET_AMOUNT)
    @dealer.bet(BET_AMOUNT)
    @player_opened_cards = false
  end

  def player_turn
    loop do
      puts "Ваши карты: #{@player.hand} (#{player_points} points)"
      puts "Карты Диллера: #{@dealer.hidden_hand}"
      puts 'Сделайте выбор: 1 - пропустить ход, 2 - Добавить карту, 3 - Открыть карты'
      case gets.chomp.to_i
      when 1
        break
      when 2
        if @player.hand.cards.size == 2
          @player.hand.add_card(@deck.draw)
        else
          puts 'вы можете добавить только одну карту'
        end
        break
      when 3
        puts "Вы открыли карты"
        @player_opened_cards = true
        break
      else
        puts 'Неправильный выбор'
      end
      break if @player.hand.cards.size == 3
    end
  end

  def dealer_turn
    if @dealer.hand.points < 17
      @dealer.hand.add_card(@deck.draw)
      puts "Дилер взял карту"
    else
      puts "Дилер пропустил ход"
    end
  end

  def reveal_cards
    puts "Ваши карты: #{@player.hand} (#{player_points} points)"
    puts "карты Диллера: #{@dealer.hand} (#{dealer_points} points)"
  end

  def settle_bets
    if player_points > 21
      puts 'Вы проиграли. Диллер победил!'
    elsif dealer_points > 21 || player_points > dealer_points
      puts 'Поздравляю! Вы выиграли!'
      @player.win(BET_AMOUNT * 2)
    elsif player_points < dealer_points
      puts 'Диллер выиграл'
      @dealer.win(BET_AMOUNT * 2)
    else
      puts 'Ничья'
      @player.win(BET_AMOUNT)
      @dealer.win(BET_AMOUNT)
    end
  end

  def player_points
    @player.hand.points
  end

  def dealer_points
    @dealer.hand.points
  end

  def play_again?
    puts 'Хотите сыграть еще раз? (y/n)'
    gets.chomp.downcase == 'y'
  end
end
