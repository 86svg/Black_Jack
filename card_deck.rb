# frozen_string_literal: true

require_relative 'card'

class Deck
  def initialize
    @cards = Card::RANKS.product(Card::SUITS).map { |rank, suit| Card.new(rank, suit) }.shuffle
  end

  def draw
    @cards.pop
  end
end
