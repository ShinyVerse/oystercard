class Oystercard

  attr_reader :balance, :entry_station, :card_history, :journey
  BALANCE_CAP = 90
  MINIMUM_DEFAULT = 1

  def initialize(balance = 0, journey = Journey.new)
    @journey = journey
    @balance = balance
    @entry_station = nil
    @card_history = []
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

  def touch_out(station = nil)
    journey.station_in = entry_station
    journey.station_out = station
    fare = journey.calculate_fare
    card_history << journey.journey_summary
    deduct(fare)
    @entry_station = nil
  end

  private
  def show_history
    card_history
  end

  def deduct(amount)
    @balance -= amount
  end
end
