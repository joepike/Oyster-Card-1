require "journey"

describe Journey do
  let(:journey) {described_class.new}
  let(:station) { double(:station) }

 it "should know that a journey is complete" do
   journey.start_journey("Temple")
   journey.end_journey("Bank")
   expect(journey.complete?).to eq true
 end

 it "should know that a journey is not complete" do
   journey.start_journey("Temple")
   expect(journey).to_not eq true
 end

 it "should know that user has not touched in" do
   expect(journey.touched_in).to eq nil
 end

 it "should know that user has not touched out" do
   expect(journey.touched_out).to eq nil
 end

 it "should charge the minimum fare for a complete journey" do
   journey.start_journey("Temple")
   journey.end_journey("Bank")
   expect(journey.fare).to eq Oystercard::DEFAULT_MINIMUM
 end

 it "should charge a penalty fare for incomplete journeys" do
   journey.start_journey("Temple")
   # journey.end_journey("Bank")
   expect(journey.fare).to eq Oystercard::PENALTY_FARE
 end

 it "should store the exit station in an instance variable" do
   subject.end_journey("Bank")
   expect(subject.touched_out).to eq("Bank")
 end

end
