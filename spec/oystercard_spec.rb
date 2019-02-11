require "oystercard"

describe Oystercard do

  let (:card) { Oystercard.new}

  it "it has an initial balance of 0" do
    expect(card.balance).to eq(0)
  end

end
