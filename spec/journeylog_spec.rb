require 'journeylog.rb'

describe JourneyLog do

  let(:journey) { double :journey, start_journey: true, end_journey: true, touched_in: true, touched_out: true}
  let(:station) { double :station }
  let(:journey_class) { double :journey_class, new: journey }
  subject(:jl) { described_class.new(journey_class: journey_class) }

  # it "should be initialized with a journey_class parameter that responds to journey methods" do
  #   expect(jl.)
  # end

  it "should initialize with an empty array of journeys" do
    expect(subject.journeys).to eq []
  end

  describe "#in_journey?" do
    it "should check if it is initially not in journey" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#start" do
    it "should start a new journey with an entry station" do
      jl.start(station)
      expect(jl.current_journey.touched_in).to be true
    end

    it "should be in_journey when touched in" do
      subject.start(station)
      expect(subject.in_journey?).to eq true
    end

  end

  describe '#finish' do
    it "should add an exit station to the current journey" do
      jl.start(station)
      jl.finish(station)
      expect(jl.current_journey.touched_out).to eq true
    end

    it "should log all journeys" do
      jl.start(station)
      expect { jl.finish(station) }.to change { jl.journeys.size }.by 1
    end

    it "should return a journey history" do
      expect(jl.journeys).to eq []
    end

    it "should not be in_journey when touched out" do
      expect(subject).to_not be_in_journey
    end

    it "creates a new journey if there is no current journey" do
      expect { subject.finish(station) }.to change { subject.journeys.size }.by 1
    end

  end

  describe "#current_journey" do
    it "should return an incomplete journey or return a new journey" do
      subject.touch_in(station)
      expect(subject.current_journey.entry_station).to !nil
    end
  end

end
