require "oystercard"

describe Oystercard do

  let (:card) { Oystercard.new}

  it "it has an initial balance of 0" do
    expect(card.balance).to eq(0)
  end

  # it { is_expected.to respond_to :top_up }

  # it { is_expected.to respond_to(:top_up).with(1).argument }

  it "will top_up card with value" do
    expect(card.top_up(50)).to eq(50)
  end

  it "#top_up raises an exception if the new balance would be greater than #{ Oystercard::MAXIMUM_BALANCE }" do
    expect { card.top_up(91) }.to raise_error "Error! New balance exceeds #{ Oystercard::MAXIMUM_BALANCE }"
  end

  it "deducts money from a card" do
    card.top_up(10)
    expect(card.deduct(5)).to eq 5
  end

  it "knows it's not in journey yet" do
    expect(card.in_journey?).to be false
  end

  it "can #touch_in" do
    card.touch_in
    expect(card.in_journey?).to be true
  end

  it "can #touch_out" do
    card.touch_in
    card.touch_out
    expect(card.in_journey?).to be false
  end

end
