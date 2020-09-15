RSpec.describe "Composable Matchers Examples" do

  # From the docs: https://relishapp.com/rspec/rspec-expectations/v/3-9/docs/composing-matchers
  #
  # RSpec's matchers are designed to be composable so that you can combine them to express
  # the exact details of what you expect but nothing more. This can help you avoid writing
  # over-specified brittle specs, by using a matcher in place of an exact value to specify only
  # the essential aspects of what you expect.
  #
  # The following matchers accept matchers as arguments:
  #
  # change { }.by(matcher)
  # change { }.from(matcher).to(matcher)
  # contain_exactly(matcher, matcher, matcher)
  # end_with(matcher, matcher)
  # include(matcher, matcher)
  # include(:key => matcher, :other => matcher)
  # match(arbitrary_nested_structure_with_matchers)
  # output(matcher).to_stdout
  # output(matcher).to_stderr
  # raise_error(ErrorClass, matcher)
  # start_with(matcher, matcher)
  # throw_symbol(:sym, matcher)
  # yield_with_args(matcher, matcher)
  # yield_successive_args(matcher, matcher)

  context "arrays of indeterminate order (i.e., Model.all <- just enough to be annoying!)" do
    let(:arr) do
      [7,8,1,2,3,4,5,6].shuffle
    end

    it "1. a collection containing exactly" do
      #expect(arr).to match(a_collection_containing_exactly(*[1,2,3,4,5,6]))
    end

    # technically under "compound expectations"
    # https://relishapp.com/rspec/rspec-expectations/v/3-9/docs/compound-expectations
    it "2. includes everything" do
      expect(arr).to include(1).and include(2).and include(3).and include(4).and include(5).and include(6)
    end

  end

  context "deeply nested hashes" do
    let(:hash_b) do
      {
        :fee => {
          id: rand(1..200),
          name: "sHoulD thIs Be Case senSitive?",
          :fie => {
            id: rand(2..20),
            :foe => {
              id: rand(3..3000),
              :fum => {
                id: rand(10..500),
                :scents => ["Englishman", "Quaker Oats", "Apples", "Gold", "Litterbox"].shuffle,
                :priority => rand(1..10)
              }
            }
          }
        }
      }
    end

    let(:composed_matching_hash) do
      {
        fee: a_hash_including({
          id: ((a_value)),
          name: a_string_matching(/should this be case sensitive\?/i),
          fie: a_hash_including({
            foe: a_hash_including({
              fum: a_hash_including({
                priority: ((a_value > 0).and (a_value < 11)), # change 11 to 10 to make this test flaky
                scents: a_collection_containing_exactly(*["Englishman", "Quaker Oats", "Apples", "Gold", "Litterbox"])
              })
            })
          })
        })
      }
    end

    it "1. matches" do
      #puts hash_b
      expect(hash_b).to match(composed_matching_hash), "expected matching hash, got #{hash_b.pretty_inspect}"
    end

    it "2. outputs helpful error message", skip: true do
      expect(hash_b).to eq(      {
          :fee => {
            id: 1,
            name: "Should This be case Sensitive?",
            :fie => {
              id: 3,
              :foe => {
                id: 20,
                :fum => {
                  id: 23,
                  :scents => ["Englishman", "Quaker Oats", "Apples", "Gold", "Litterbox"],
                  :priority => 1
                }
              }
            }
          }
        }), "expected matching hash, got #{hash_b.pretty_inspect}"
    end
  end
end
