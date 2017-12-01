require "./lib/journey"
require './lib/station'
require './lib/journeylog'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys, :journey, :fare

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new()
  end

  def top_up(money)
    raise "You have reached a top up limit of £#{DEFAULT_LIMIT}" if  money + @balance > DEFAULT_LIMIT
    @balance += money
  end

  # def in_journey?
  #   !!@journey_log.@journey
  # end

  def touch_in(entry_station)
    double_touch_in if @journey_log.in_journey?
    raise "Insufficient balance for journey" if @balance < 1
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    # @journey_log.current_journey = journey if !in_journey?
    @journey_log.finish(exit_station)
    deduct(@journey_log.current_journey.fare)
    @journey_log.reset_current_journey
  end

  private

  def double_touch_in
    deduct(@journey_log.current_journey.fare)
    @journey_log.journey_reset
    @journey_log.reset_current_journey
  end

  # def journey_reset
  #   @journeys << @journey
  #   @journey = nil
  # end

  def deduct(amount)
    @balance -= amount
  end

end
