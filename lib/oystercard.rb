class Oystercard

  attr_reader :balance
  BALANCE_CAP = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    error = "Unable to top up beyond #{BALANCE_CAP}. You currently have: £#{balance}"
    raise error if (@balance + amount) > BALANCE_CAP
    @balance += amount
  end
end
