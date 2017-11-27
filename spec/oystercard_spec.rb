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


end
