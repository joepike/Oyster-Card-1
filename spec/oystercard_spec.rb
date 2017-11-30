require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to :balance }

  let(:station) { double(:station) }
  let(:journey) { double(:journey, fare: Oystercard::DEFAULT_MINIMUM, start_journey: true, end_journey: true)}
  let(:penalty_journey) { double(:journey, fare: Oystercard::PENALTY_FARE, start_journey: true, end_journey: true)}

  it 'should initialize with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it "should initialize with an empty array of journeys" do
    expect(subject.journeys).to eq []
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

      context "with top-up" do

        before do
          subject.top_up(90)
          subject.touch_in(station, journey)
        end

        it "should be in_journey when touched in" do
          expect(subject.in_journey?).to eq true
        end

        it "should charge a penalty for double touch_in" do
          subject.touch_out(station)
          subject.touch_in(station, penalty_journey)
          expect { subject.touch_in(station, penalty_journey) }.to change { subject.balance }.by(-Oystercard::PENALTY_FARE)
        end

    end

  end

  describe "#touch_out" do

    before do
      subject.top_up(10)
      subject.touch_in(station, journey)
      subject.touch_out(station)
    end

     it "should not be in_journey when touched out" do
       expect(subject).to_not be_in_journey
     end

     it "should deduct the correct fare when touched out" do
       subject.touch_in(station, journey)
       expect { subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::DEFAULT_MINIMUM)
     end

     it "should remove entry station from the instance variable" do
       expect(subject.entry_station).to eq nil
     end

     it "creates a new journey if there is no current journey" do
       expect { subject.touch_out(station, journey) }.to change { subject.journeys.size }.by 1
     end

  end

  describe "#record_journey" do

    it "record journey history" do
      subject.top_up(10)
      subject.touch_in(station, journey)
      expect { subject.touch_out(station) }.to change { subject.journeys.size }.by 1
    end

  end
end
