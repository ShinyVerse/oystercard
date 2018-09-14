require 'journeylog'

describe JourneyLog do
  let(:journey) { double('a journey') }
  let(:journeylog) { described_class.new(journey)}
  let(:entry_station) { double('a station', name: 'Aldgate East', zone: 1) }
  let(:exit_station) { double('another station', name: 'Bow road', zone: 2)}

  context '#start_tracking' do
    it 'stores the start of a journey to station1' do
      journeylog.start_tracking(entry_station)

      expect(journeylog.entry_point).to eq entry_station
    end
  end

  context '#stop_tracking' do
    it 'stores the end of a journey to station2' do
      journeylog.stop_tracking(exit_station)

      expect(journeylog.exit_point).to eq exit_station
    end
  end

  context '#store_journey' do
    it 'stores the journey in the history_log' do
      journeylog.start_tracking(entry_station)
      journeylog.stop_tracking(exit_station)
      allow(journey).to receive(:calculate_fare) {1}
      journeylog.store_journey

      expect(journeylog.history_log).to include({entry: entry_station, exit: exit_station, price: journeylog.process_fare })
    end
  end
end

# require './lib/journey.rb'
# require './lib/oystercard.rb'
#  require './lib/journeylog.rb'
#  require './lib/station.rb'
#
#  station1 = Station.new('A', 1)
#  station2 = Station.new('B', 2)
#  card = Oystercard.new
#  card.top_up(10)
#  card.touch_in(station1)
#  card.touch_out(station2)
#  card.journeylog.history_log
