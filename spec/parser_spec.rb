# NOTE: This spec does not mock the lexer used in SimplestSqlParser::Parser.
#       That is, this tests SimplestSqlParser::Parser with SimplestSqlParser::Parser used in it.
RSpec.describe SimplestSqlParser::Parser do
  context "when query includes only an expression" do
    it "generates the AST" do
      ast = described_class.new("name").do_parse
      expect(ast.self_and_descendants).to eq({
        "AST::ExpressionNode(value=name)" => {}
      })
    end
  end
end
