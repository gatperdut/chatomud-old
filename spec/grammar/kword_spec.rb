require "grammar/support"
require "spec_helper"

RSpec.describe ChatoMud::Grammar::Parser do
  let!(:parser) { ChatoMud::Grammar::Parser.new }

  let(:queries) do
    JSON.parse(file_fixture("grammar/#{File.basename(__FILE__, '.rb')}.json").read)
  end

  describe ChatoMud::Grammar::Parser do
    context "kword" do
      it "can parse with indexes" do
        queries["with_index"].each do |query|
          expect(JSON.parse(parser.kword.parse(query[0]).to_json)).to eq(query[1])
        end
      end

      it "can parse without indexes" do
        queries["without_index"].each do |query|
          expect(JSON.parse(parser.kword.parse(query[0]).to_json)).to eq(query[1])
        end
      end

      it "does not parse badly formed input" do
        queries["badly_formed"].each do |query|
          expect(parser.kword).to_not parse(query)
        end
      end
    end
  end
end
