class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  def value
    case @rank
    when %w[J Q K] then 10
    when 'A' then 11
    end
  end
end
