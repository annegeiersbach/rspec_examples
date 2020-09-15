RSpec.describe "slow specs", slow: true do

  it "1. takes 2 secs" do
    expect(sleep(2)).to be
  end

  it "2. takes 20 secs" do
    expect(sleep(10)).to be
  end

end
