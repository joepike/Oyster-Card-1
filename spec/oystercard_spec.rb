require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to :balance }

  it 'should initialize with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "should let me top up with any amount" do
      expect{ subject.top_up(10) }.to change {subject.balance}.by 10
    end

    it 'should set a top up limit of 90 pounds' do
      limit = Oystercard::DEFAULT_LIMIT
      subject.top_up(limit)
      expect{ subject.top_up(1) }.to raise_error "You have reached a top up limit of £#{limit}"
    end

    it "should raise error if initial balance is not nil before top_up" do
      limit = Oystercard::DEFAULT_LIMIT
      subject.top_up(10)
      expect{ subject.top_up(limit) }.to raise_error "You have reached a top up limit of £#{limit}"
    end
  end

  describe "#in_journey?" do
    it "should check if it is initially not in journey" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it "should be in_journey when touched in" do
      subject.top_up(Oystercard::DEFAULT_MINIMUM)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "should raise an error when attempting to touch in with balance of < £#{Oystercard::DEFAULT_MINIMUM}" do
      expect {subject.touch_in }.to raise_error "Insufficient balance for journey"
    end

  end

  describe "#touch_out" do
     it "should not be in_journey when touched out" do
       subject.touch_out
       expect(subject).to_not be_in_journey
     end

     it "should deduct a given amount when touched out" do
       expect { subject.touch_out }.to change{ subject.balance }.by(-Oystercard::DEFAULT_MINIMUM)
     end

  end


end
