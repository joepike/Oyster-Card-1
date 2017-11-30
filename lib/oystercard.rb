require "./lib/journey"
require './lib/station'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys, :journey, :fare

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journeys = []
    @journey = nil
  end

  def top_up(money)
    raise "You have reached a top up limit of £#{DEFAULT_LIMIT}" if  money + @balance > DEFAULT_LIMIT
    @balance += money
  end

  def in_journey?
    !!@journey
  end

  def touch_in(entry_station, journey = Journey.new)
    double_touch_in if in_journey?
    @journey = journey
    raise "Insufficient balance for journey" if @balance < 1
    @journey.start_journey(entry_station)
  end

  def touch_out(exit_station, journey = Journey.new)
    @journey = journey if !in_journey?
    @journey.end_journey(exit_station)
    deduct(@journey.fare)
    journey_reset
  end

  private

  def double_touch_in
    deduct(@journey.fare)
    journey_reset
  end

  def journey_reset
    @journeys << @journey
    @journey = nil
  end

  def deduct(amount)
    @balance -= amount
  end

end
