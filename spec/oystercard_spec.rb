require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to :balance }

  it 'should initialize with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it "should let me top up with 10" do
    expect(subject.top_up(10)).to eq 10
  end

  it "should let me top up with 15" do
    expect(subject.top_up(15)).to eq 15
  end

  it "should add the top up amount to the balance" do
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end

  it 'should set a top up limit of 90 pounds' do
    limit = Oystercard::DEFAULT_LIMIT
    subject.top_up(limit)
    expect{ subject.top_up(1) }.to raise_error "You have reached a top up limit of £#{limit}"
  end

  it "should raise error if initial balance is not nil before top_up" do
    limit = Oystercard::DEFAULT_LIMIT
    subject.top_up(10)
    expect{ subject.top_up(limit) }.to raise_error "You have reached a top up limit of £#{limit}"
  end


end
