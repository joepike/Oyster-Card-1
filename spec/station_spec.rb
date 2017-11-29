require 'station'

describe Station do

  subject(:station) {described_class.new("Bank", 1)}

  it "it know's its name" do
    expect(subject.name).to eq "Bank"
  end

  it "knows its zone" do
    expect(subject.zone).to eq 1
  end

end
