# NOTE: This spec does not mock the lexer used in SimplestSqlParser::Parser.
#       That is, this tests SimplestSqlParser::Parser with SimplestSqlParser::Parser used in it.
RSpec.describe SimplestSqlParser::Parser do
  context "when query includes only SELECT statement" do
    it "generates the AST" do
      ast = described_class.new("SELECT name").do_parse
      expect(ast.self_and_descendants).to eq({
        "AST::QueryNode" => {
          "select_statement" => {
            "AST::SelectStatementNode" => {
              "columns" => [
                "AST::ColumnNode" => {
                  "col_def" => {
                      "AST::ExpressionNode(value=name)" => {}
                  }
                }
              ]
            }
          },
          "from_statement" => nil,
          "where_statement" => nil,
        }
      })
    end
  end
end
