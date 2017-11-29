

class Journey

  PENALTY_FARE = 6

  def initialize()
    @entry_station = nil
    @exit_station = nil
    @complete = nil
  end

  def start_journey(station)
    @entry_station = station
  end

  def end_journey(station)
    @exit_station = station
    @complete = true
    # @journeys << @journey
  end

  def complete
    @complete
  end

  def fare
    !touched_in.nil? && !touched_out.nil? ? Oystercard::DEFAULT_MINIMUM : 6
  end

  def touched_in
    @entry_station
  end

  def touched_out
    @exit_station
  end

  def in_journey
    @entry_station != nil
  end


end
