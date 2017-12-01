

class Journey

  attr_reader :entry_station

  def start_journey(station)
    @entry_station = station
    @complete = try_to_complete_journey
  end

  def end_journey(station)
    @exit_station = station
    @complete = try_to_complete_journey
  end

  def complete?
    @complete
  end

  def fare
    complete? ? calc_fare : 6
  end

  def try_to_complete_journey
    !touched_in.nil? && !touched_out.nil?
  end

  def touched_in
    @entry_station
  end

  def touched_out
    @exit_station
  end

  def in_journey?
    !!@entry_station
  end

  def calc_fare
    @entry_station.zone == @exit_station.zone ? Oystercard::DEFAULT_MINIMUM : (@entry_station.zone - @exit_station.zone).abs
  end


end
