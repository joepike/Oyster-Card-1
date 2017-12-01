require './lib/journey.rb'

class JourneyLog
  attr_reader :current_journey

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    @current_journey = @journey_class.new
    @current_journey.start_journey(station)
  end

  def finish(station)
    @current_journey = @journey_class.new if !in_journey?
    @current_journey.end_journey(station)
    # @journeys << @current_journey
    journey_reset
  end

  def journeys
    @journeys.dup
  end

  def in_journey?
    !!@current_journey
  end

  def journey_reset
    @journeys << @current_journey
  end

  def reset_current_journey
    @current_journey = nil
  end

end
