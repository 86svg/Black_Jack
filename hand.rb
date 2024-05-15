# frozen_string_literal: true

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def points
    sum = 0
    ace_count = 0

    @cards.each do |card|
      sum += card.value
      ace_count += 1 if card.rank == 'A'
    end

    ace_count.times { sum -= 10 if sum > 21 }

    sum
  end

  def to_s
    @cards.map(&:to_s).join(', ')
  end
end
