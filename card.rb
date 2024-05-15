# frozen_string_literal: true

class Card
  attr_reader :rank, :suit

  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[♠ ♥ ♦ ♣].freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    return rank.to_i if rank.to_i != 0
    return 10 if %w[J Q K].include?(rank)

    11 if rank == 'A'
  end

  def to_s
    "#{rank}#{suit}"
  end
end
