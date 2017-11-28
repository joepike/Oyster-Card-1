

class Oystercard
  attr_reader :balance
  attr_accessor :in_journey

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    raise "You have reached a top up limit of £#{DEFAULT_LIMIT}" if  money + @balance > DEFAULT_LIMIT
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Insufficient balance for journey" if @balance < 1
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
