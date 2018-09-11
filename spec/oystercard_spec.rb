require 'oystercard'

describe Oystercard do
  let(:station) { double :station }

  context 'When card is new' do
    let(:subject) { Oystercard.new }

    it 'tops up balance to passed amount' do
      subject.top_up(10)
      expect(subject::balance).to eq 10
    end

    it 'Raises an error when user has insufficient funds on card' do
      expect { subject.touch_in(station) }.to raise_error "Insufficient funds"
    end

  end

  context 'When card has money on it' do
    let(:subject) { Oystercard.new(50) }

    it 'raises error if attempting to top_up beyond capped limit' do
      message = "Unable to top up beyond #{Oystercard::BALANCE_CAP}. You currently have: £#{subject.balance}"
      expect{ subject.top_up(50) }.to raise_error(message)
    end

    xit 'changes @use_in to true when touch_in called' do
      subject.touch_in(station)

      expect(subject::entry_station).to eq station
    end

    it 'changes balance when charge is made' do
      subject.touch_in(station)

      expect{ subject.touch_out }.to change{subject.balance}.by (-5)
    end

    it 'remembers the entry station' do
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

 end

 context 'When card is in use' do
   let(:subject) { Oystercard.new(50) }

   before(:each) do
      subject.touch_in(station)
   end

    it 'changes @use_in to false when touch_out is called' do
      subject.touch_out

      expect(subject::entry_station).to eq nil
    end

  end

end
