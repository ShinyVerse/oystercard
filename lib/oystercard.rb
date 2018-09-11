class Oystercard

  attr_reader :balance, :entry_station, :journey_log
  BALANCE_CAP = 90
  MINIMUM_DEFAULT = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @journey_log = []
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

  def touch_out(station)
    deduct(5)
    store_journey(@entry_station, station)
    @entry_station = nil
  end

  private

  def store_journey(station_in, station_out)
    @journey_log << {station_in => station_out}
  end

  def in_journey?
    !entry_station
  end

  def deduct(amount)
    @balance -= amount
  end
end
