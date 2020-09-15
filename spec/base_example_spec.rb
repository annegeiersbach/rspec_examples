RSpec.describe "Basic Examples (the built-in matchers)" do

  context "A. basic array operations" do

    it "1. includes element" do
      expect([1,2,3]).to include(1)
    end

    it "2. equals itself" do
      expect([1,2,3]).to eq([1,2,3]) # order matters
    end

    it "3. matches itself" do
      expect([1,2,3]).to match([1,2,3]) # order matters
      expect([1,2,3]).to match_array([1,2,3]) # order matters
    end


    it "4. contains exactly" do
      expect([1,2,3]).to contain_exactly(2,3,1) # can be any order
      expect([1,2,3]).to contain_exactly(*[1,2,3].shuffle) #splat array also works
    end

    it "5. satisfy with block" do
      expect([1,2,3]).to satisfy{|ar| ar.size == 3 }
    end

    context "change length" do
      let(:arr) { [1,2,3] }
      subject   { arr.push(4) }

      # unreliable with database transactions, threaded tests
      it "6. size is now 4" do
        subject
        expect(arr.size).to eq(4)
      end

      it "7. expect subject to change by 1" do
        expect { subject }.to change{ arr.size }.by(1)
      end
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
