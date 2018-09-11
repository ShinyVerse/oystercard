

class Journey
  attr_accessor :station_in, :station_out
  attr_reader :fare
  def initialize(station_in = nil, station_out = nil)
    @fare = fare
    @station_in = station_in
    @station_out = station_out
  end

  def calculate_fare
    if station_in == nil || station_out == nil
      @fare = 6
    else
      @fare = 1
    end
  end

  def journey_summary
    {"entry"=> station_in, 'out' => station_out, "price"=> fare }
  end


  private

  def in_journey?
    !entry_station
  end
end
