class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize(initial_balance = 0)
    @balance = initial_balance
  end

  def top_up(value)
    raise "Error! New balance exceeds #{ MAXIMUM_BALANCE }" if @balance + value > MAXIMUM_BALANCE
    @balance += value
  end

  def in_journey?
    true unless entry_station.nil?
  end

  def touch_in(entry_station)
    raise "Insufficient funds." if @balance < MINIMUM_FARE
    @entry_station = entry_station
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  def deduct(value)
    @balance -= value
  end

end
