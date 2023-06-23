# NOTE: This spec does not mock the lexer used in SimplestSqlParser::Parser.
#       That is, this tests SimplestSqlParser::Parser with SimplestSqlParser::Parser used in it.
RSpec.describe SimplestSqlParser::Parser do
  let(:parser) { described_class.new }

  context "when a query includes SELECT statement" do
    it "tokenizes the query" do
      parser = described_class.new("SELECT name")
      print parser.do_parse
    end
  end
end
