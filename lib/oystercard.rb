class Oystercard
    BALANCE = 0
    MAX_BALANCE = 90
    FARE = 1
    attr_reader :balance, :journeylog, :max_balance

  def initialize(balance = BALANCE, journeylog = JourneyLog.new)
    @balance = balance
    @max_balance = MAX_BALANCE
    @journeylog = journeylog
    @being_used = false
  end

  def top_up(top_up_value)
    fail "Card has reached its £#{max_balance} limit!" if top_up_value + balance > MAX_BALANCE
    @balance += top_up_value
  end

  def touch_in(station)
    fail "Already touched in!" if in_use?
    fail "Not enough money on card! #{balance_writer}" if balance < FARE
    being_used
    journeylog.start_tracking(station)
  end

  def touch_out(station)
    fail 'Already touched out!' unless in_use?
    journeylog.stop_tracking(station)
    being_used
    journeylog.store_journey
    deduct(journeylog.process_fare)
  end

  private
  attr_reader :in_use

  def deduct(amount)
    @balance -= amount
  end

  def being_used
    @in_use = !in_use
  end

  def in_use?
    @in_use
  end

  def balance_writer
     balance < 0 ? "Your balance is -£#{-balance}"  : "Your balance is £#{balance}"
  end
end
