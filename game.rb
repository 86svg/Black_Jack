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
      dealer_turn unless @player.hand.cards.size == 3
      reveal_cards
      settle_bets
      break unless play_again?
    end
  end

  private

  def ask_player_name
    puts 'Enter your name:'
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
  end

  def player_turn
    loop do
      puts "Your cards: #{@player.hand} (#{player_points} points)"
      puts "Dealer's cards: #{@dealer.hidden_hand}"
      puts 'Choose an action: 1 - Skip, 2 - Add card, 3 - Open cards'
      case gets.chomp.to_i
      when 1
        break
      when 2
        if @player.hand.cards.size == 2
          @player.hand.add_card(@deck.draw)
        else
          puts 'You can only add one card.'
        end
        break
      when 3
        break
      else
        puts 'Invalid choice, please try again.'
      end
      break if @player.hand.cards.size == 3
    end
  end

  def dealer_turn
    @dealer.hand.add_card(@deck.draw) while @dealer.hand.points < 17 && @dealer.hand.cards.size < 3
  end

  def reveal_cards
    puts "Your cards: #{@player.hand} (#{player_points} points)"
    puts "Dealer's cards: #{@dealer.hand} (#{dealer_points} points)"
  end

  def settle_bets
    if player_points > 21
      puts 'You busted! Dealer wins.'
    elsif dealer_points > 21 || player_points > dealer_points
      puts 'You win!'
      @player.win(BET_AMOUNT * 2)
    elsif player_points < dealer_points
      puts 'Dealer wins.'
      @dealer.win(BET_AMOUNT * 2)
    else
      puts 'It\'s a tie!'
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
    puts 'Do you want to play again? (y/n)'
    gets.chomp.downcase == 'y'
  end
end
