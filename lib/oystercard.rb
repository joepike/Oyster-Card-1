

class Oystercard
  attr_reader :balance

  DEFAULT_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise "You have reached a top up limit of £#{DEFAULT_LIMIT}" if  money + @balance > DEFAULT_LIMIT
    @balance += money
  end
end
