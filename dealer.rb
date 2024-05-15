# frozen_string_literal: true

require_relative 'player'

class Dealer < Player
  def initialize
    super('Dealer')
  end

  def hidden_hand
    @hand.cards.map { '*' }.join(' ')
  end
end
