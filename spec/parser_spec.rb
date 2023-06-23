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
              "selected_columns" => [
                {
                  "AST::SelectedColumnNode(alias_name=)" => {
                    "col_def" => {
                      "AST::ColumnNode(type=single_col,name=name)" => {}
                    }
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

  context "when query includes SELECT, FROM statement" do
    it "generates the AST" do
      ast = described_class.new("SELECT name FROM table").do_parse
      expect(ast.self_and_descendants).to eq({
        "AST::QueryNode" => {
          "select_statement" => {
            "AST::SelectStatementNode" => {
              "selected_columns" => [
                {
                  "AST::SelectedColumnNode(alias_name=)" => {
                    "col_def" => {
                      "AST::ColumnNode(type=single_col,name=name)" => {}
                    }
                  }
                },
              ]
            }
          },
          "from_statement" => {
            "AST::FromStatementNode" => {
              "table" => {
                "AST::TableNode(alias_name=)" => {
                  "table_def" => {
                    "AST::ExpressionNode(value=table)" => {}
                  }
                }
              }
            }
          },
          "where_statement" => nil,
        }
      })
    end

    it "generates the AST" do
      ast = described_class.new("SELECT name, address, age FROM table").do_parse
      expect(ast.self_and_descendants).to eq({
        "AST::QueryNode" => {
          "select_statement" => {
            "AST::SelectStatementNode" => {
              "selected_columns" => [
                {
                  "AST::SelectedColumnNode(alias_name=)" => {
                    "col_def" => {
                      "AST::ColumnNode(type=single_col,name=name)" => {}
                    }
                  }
                },
                {
                  "AST::SelectedColumnNode(alias_name=)" => {
                    "col_def" => {
                      "AST::ColumnNode(type=single_col,name=address)" => {}
                    }
                  }
                },
                {
                  "AST::SelectedColumnNode(alias_name=)" => {
                    "col_def" => {
                      "AST::ColumnNode(type=single_col,name=age)" => {}
                    }
                  }
                },
              ]
            }
          },
          "from_statement" => {
            "AST::FromStatementNode" => {
              "table" => {
                "AST::TableNode(alias_name=)" => {
                  "table_def" => {
                    "AST::ExpressionNode(value=table)" => {}
                  }
                }
              }
            }
          },
          "where_statement" => nil,
        }
      })
    end
  end
end
