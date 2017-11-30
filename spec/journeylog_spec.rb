require 'journeylog.rb'

describe JourneyLog do

  let(:journey) { double :journey, start_journey: true, end_journey: true, touched_in: true, touched_out: true}
  let(:station) { double :station }
  let(:journey_class) { double :journey_class, new: journey }
  subject(:jl) { described_class.new(journey_class: journey_class) }

  # it "should be initialized with a journey_class parameter that responds to journey methods" do
  #   expect(jl.)
  # end

  describe "#start" do
    it "should start a new journey with an entry station" do
      jl.start(station)
      expect(jl.current_journey.touched_in).to be true
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

  end

end
