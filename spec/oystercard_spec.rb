require 'oystercard'

describe Oystercard do

  context 'When card is new' do
    let(:subject) { Oystercard.new }

    it 'has balance as an instance variable' do
      expect(subject::balance).to eq 0
    end

    it 'tops up balance to passed amount' do
      subject.top_up(10)
      expect(subject::balance).to eq 10
    end

  end

  context 'When card has money on it' do
    let(:subject) { Oystercard.new(50) }

    it 'raises error if attempting to top_up beyond capped limit' do
      message = "Unable to top up beyond #{Oystercard::BALANCE_CAP}. You currently have: £#{subject.balance}"
      expect{ subject.top_up(50) }.to raise_error(message)
    end

    it 'allows you to deduct an amount' do
      subject.deduct(10)
      expect(subject.balance).to eq 40
    end
  end

end
