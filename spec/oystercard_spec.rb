require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to :balance }

  it 'should initialize with a balance of zero' do
    expect(subject.balance).to eq 0
  end
end
