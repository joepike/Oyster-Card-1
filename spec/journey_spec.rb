require "journey"

describe Journey do
  let(:journey) {described_class.new}
  let(:station) { double(:station) }

 it "should know that a journey is complete" do
   journey.start_journey(station)
   journey.end_journey(station)
   expect(journey.complete?).to eq true
 end

 it "should know that a journey is not complete" do
   journey.start_journey(station)
   expect(journey).to_not eq true
 end

 it "should know that user has not touched in" do
   expect(journey.touched_in).to eq nil
 end

 it "should know that user has not touched out" do
   expect(journey.touched_out).to eq nil
 end

 it "should charge a penalty fare for incomplete journeys" do
   journey.start_journey(station)
   # journey.end_journey(station)
   expect(journey.fare).to eq Oystercard::PENALTY_FARE
 end

 it "should store the exit station in an instance variable" do
   subject.end_journey(station)
   expect(subject.touched_out).to eq(station)
 end

end
