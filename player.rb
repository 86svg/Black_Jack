
class Player
  attr_accessor :name, :hand, :bank

  MAX_CARDS = 3

  def initialize(name)
    @name = name
    @bank = 100
    @hand = []
  end

  def bet
    @bank -= 10
  end

end
