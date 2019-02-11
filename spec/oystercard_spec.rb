require "oystercard"

describe Oystercard do

  let (:card) { Oystercard.new(10) }
  let (:station) { double(:station) }
  let (:exit_station) { double(:exit_station) }

  it "it has an initial balance of 0" do
    expect(card.balance).to eq(10)
  end

  it "will top_up card with value" do
    expect(card.top_up(50)).to eq(60)
  end

  it "#top_up raises an exception if the new balance would be greater than #{ Oystercard::MAXIMUM_BALANCE }" do
    expect { card.top_up(91) }.to raise_error "Error! New balance exceeds #{ Oystercard::MAXIMUM_BALANCE }"
  end

  it "knows it's not in journey yet" do
    expect(card.in_journey?).to be_falsey
  end

  it "can #touch_in" do
    card.touch_in(station)
    expect(card.in_journey?).to be true
  end

  it "can #touch_out" do
    card.touch_in(station)
    card.touch_out(exit_station)
    expect(card.in_journey?).to be_falsey
  end

  it "will not let you travel with less than less than the minimum balance" do
    low_card = Oystercard.new(0.5)
    expect{ low_card.touch_in(station) }.to raise_error("Insufficient funds.")
  end

  it "#touch_out charges the minimum fare" do
    expect { card.touch_out(exit_station) }.to change { card.balance }.by(-1)
  end

  it "can remember entry_station after touch in" do
    card.touch_in(station)
    expect(card.entry_station).to eq(station)
  end

  it "#touch_out sets entry_station to nil" do
    card.touch_in(station)
    card.touch_out(exit_station)
    expect(card.in_journey?).to be nil
  end

  it '#touch_out adds an exit station' do
    card.touch_in(station)
    card.touch_out(exit_station)
    expect(card.journey_history.select { |element| element[:exit] }).to eq(exit_station)
  end

  it "stores a journey history" do
    card.touch_in(station)
    card.touch_out(exit_station)
    expect(card.journey_history).to eq([{entry: station, exit: exit_station}])
  end

end
