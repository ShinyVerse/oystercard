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

end
