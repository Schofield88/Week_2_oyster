class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize(initial_balance = 0)
    @balance = initial_balance
    @in_use = false
  end

  def top_up(value)
    raise "Error! New balance exceeds #{ MAXIMUM_BALANCE }" if @balance + value > MAXIMUM_BALANCE
    @balance += value
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise "Insufficient funds." if @balance < MINIMUM_FARE
    @entry_station = "Finsbury Park"
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_use = false
  end


  private

  def deduct(value)
    @balance -= value
  end

end
