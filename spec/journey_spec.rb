require 'journey'

describe Journey do
  let(:in_station) { double :station }
  let(:out_station) { double :station }
  it 'calculates fare as 1 when both stations entered' do
    journey = Journey.new(in_station,out_station )
    expect(journey.calculate_fare).to eq 1
  end

  it 'calculates fare as 6 when a station value is nil' do
    journey = Journey.new(in_station)
    expect(journey.calculate_fare).to eq 6
  end

end
