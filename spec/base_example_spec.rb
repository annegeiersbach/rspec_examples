RSpec.describe "Basic Examples (the built-in matchers)" do

  context "A. basic array operations" do

    it "1. includes element" do
      expect([1,2,3]).to include(1)
    end

    it "2. equals itself" do
      expect([1,2,3]).to eq([1,2,3])
    end

    it "3. matches itself" do
      expect([1,2,3]).to match([1,2,3])
      expect([1,2,3]).to match_array([1,2,3])
    end


    it "4. contains exactly" do
      expect([1,2,3]).to contain_exactly(1,2,3)
      expect([1,2,3]).to contain_exactly(*[1,2,3]) #splat array also works
    end
  end

  context "B. basic hash operations" do
    let(:hash_a) do
      {
        :foo => "bar",
        "baz" => "bing"
      }
    end

    it "1. matches itself" do
      expect(hash_a).to match({ :foo => 'bar', 'baz' => 'bing'}) # note 'baz' not :baz
    end

    it "2. equals itself" do
      expect(hash_a).to eq({ foo: 'bar', 'baz' => 'bing'})
    end

    it "3. includes elements" do
      expect(hash_a).to include(:foo => 'bar')
      expect(hash_a).to include(:foo => 'bar', 'baz' => 'bing')
    end

    # this is really an array operation but whatevs
    # hash.to_a => array of [key, value]
    it "4. contains exactly" do
      expect(hash_a.to_a).to contain_exactly([:foo, 'bar'], ['baz', 'bing'])
    end

    it "5. satisfy provides a block" do
      expect(hash_a).to satisfy {|h|
        h[:foo] == "bar"
      }
    end
  end

end
