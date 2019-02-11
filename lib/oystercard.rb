class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance

  def initialize(initial_balance = 0)
    @balance = initial_balance
    @in_use = false
  end

  def top_up(value)
    raise "Error! New balance exceeds #{ MAXIMUM_BALANCE }" if @balance + value > MAXIMUM_BALANCE
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise "Insufficient funds." if @balance < MINIMUM_FARE
    @in_use = true
  end

  def touch_out
    @balance -= MINIMUM_FARE
    @in_use = false
  end

end
