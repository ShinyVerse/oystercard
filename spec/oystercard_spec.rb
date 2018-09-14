require 'oystercard'

describe Oystercard do
  let(:oystercard) { described_class.new(0, journeylog)}
  let(:entry_station) { double('a station', name: 'Aldgate East', zone: 1) }
  let(:exit_station) { double('another station', name: 'Bow road', zone: 2)}
  let(:journey) { double('journey') }
  let(:journeylog) { double('journeylog', start_tracking: entry_station, stop_tracking: exit_station )}

 context '#top_up' do
   it 'tops up oystercard' do
     oystercard.top_up(2)

     expect(oystercard.balance).to eq(2)
   end

   it "Raises an error when card is full" do
     max_balance = Oystercard::MAX_BALANCE
     oystercard.top_up(max_balance)

     expect { oystercard.top_up 1 }.to raise_error("Card has reached its £#{max_balance} limit!")
   end
 end

context '#touch_in' do
  it 'raises error when not enough money' do
    fare = Oystercard::FARE
    balance = Oystercard::BALANCE

    expect { oystercard.touch_in(entry_station) }.to raise_error("Not enough money on card! Your balance is £#{balance}")
  end

  it 'returns station on touch in' do
   oystercard.top_up(10)
   oystercard.touch_in(entry_station)

   expect(journeylog.start_tracking(entry_station)).to eq entry_station
 end
end

 context '#touch_out' do
   it 'should deduct fare upon touch out' do
     oystercard.top_up(10)
     oystercard.touch_in(entry_station)
     allow(journeylog).to receive(:process_fare) {1}
     allow(journeylog).to receive(:store_journey)

     expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-1 )
   end
 end
end
