require "journey"

describe Journey do
  let(:journey) {described_class.new}

 it "should know that a journey is complete" do
   journey.start_journey("Temple")
   journey.end_journey("Bank")
   expect(journey).to be_complete
 end

 it "should know that a journey is not complete" do
   journey.start_journey("Temple")
   expect(journey).to_not be_complete
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
   expect(journey.fare).to eq Journey::PENALTY_FARE
 end

end
