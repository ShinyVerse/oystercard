class Oystercard

  attr_reader :balance, :entry_station
  BALANCE_CAP = 90
  MINIMUM_DEFAULT = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    error = "Unable to top up beyond #{BALANCE_CAP}. You currently have: £#{balance}"
    raise error if (@balance + amount) > BALANCE_CAP
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_DEFAULT
    @entry_station = station
  end

  def touch_out
    deduct(5)
    @entry_station = nil
  end

  private

  def in_journey?
    !entry_station
  end

  def deduct(amount)
    @balance -= amount
  end
end
