class JourneyLog
  attr_reader :history_log, :journey, :entry_point, :exit_point
  def initialize(journey = Journey.new)
    @journey = journey
    @history_log = []
    @entry_point = nil
    @exit_point = nil
  end

  def start_tracking(station = nil)
    @entry_point = station
  end

  def stop_tracking(station = nil)
    @exit_point = station
  end

  def store_journey
    @history_log << {entry: entry_point, exit: exit_point, price: process_fare}
  end

  def process_fare
    journey.calculate_fare(entry_point.zone, exit_point.zone)
  end
end
