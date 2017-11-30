require './lib/journey.rb'

class JourneyLog
  attr_reader :current_journey

  def initialize(journey_class: )
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    @current_journey = @journey_class.new
    @current_journey.start_journey(station)
  end

  def finish(station)
    @current_journey.end_journey(station)
    @journeys << @current_journey
  end

  def journeys
    @journeys.dup
  end

end
