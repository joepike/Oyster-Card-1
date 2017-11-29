

class Journey

  PENALTY_FARE = 6

  def initialize()
    @journey = {:entry_station => nil , :exit_station => nil, :complete => nil}
  end

  def start_journey(station)
    @journey[:entry_station] = station
  end

  def end_journey(station)
    @journey[:exit_station] = station
    @journey[:complete] = true
    # @journeys << @journey
  end

  def complete?
    @journey[:complete] == true
  end

  def fare
    !touched_in.nil? && !touched_out.nil? ? Oystercard::DEFAULT_MINIMUM : 6
  end

  def touched_in
    @journey[:entry_station]
  end

  def touched_out
    @journey[:exit_station]
  end


end
