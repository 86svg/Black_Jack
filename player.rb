# frozen_string_literal: true

# player.rb
require_relative 'hand'

class Player
  attr_reader :name, :hand, :bank

  def initialize(name, bank = 100)
    @name = name
    @hand = Hand.new
    @bank = bank
  end

  def bet(amount)
    @bank -= amount
    amount
  end

  def win(amount)
    @bank += amount
  end

  def reset_hand
    @hand = Hand.new
  end
end
