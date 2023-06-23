# NOTE1: To compare the generated AST with an expected AST, #self_and_descendants of the generated AST is used.
#        The reason is that comparing two AST does not work well because object_ids of compared nodes are different, even if the structures are the same.
# NOTE2: This spec does not mock the lexer used in SimplestSqlParser::Parser.
#        That is, this tests SimplestSqlParser::Parser with SimplestSqlParser::Parser used in it.
RSpec.describe SimplestSqlParser::Parser do
  context "when query includes only SELECT statement" do
    it "generates the AST" do
      ast = described_class.new("SELECT name").do_parse
      expect(ast.self_and_descendants).to eq({
        "AST::QueryNode()" => {
          "select_clause" => {
            "AST::SelectClauseNode()" => {
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
          "from_clause" => nil,
          "where_clause" => nil,
        }
      })
    end
  end

  context "when query includes SELECT, FROM statement" do
    it "generates the AST" do
      ast = described_class.new("SELECT name FROM table").do_parse
      expect(ast.self_and_descendants).to eq({
        "AST::QueryNode()" => {
          "select_clause" => {
            "AST::SelectClauseNode()" => {
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
          "from_clause" => {
            "AST::FromClauseNode()" => {
              "table" => {
                "AST::TableNode(alias_name=)" => {
                  "table_def" => {
                    "AST::ExpressionNode(value=table)" => {}
                  }
                }
              }
            }
          },
          "where_clause" => nil,
        }
      })
    end

    it "generates the AST" do
      ast = described_class.new("SELECT name, address, age FROM table").do_parse
      expect(ast.self_and_descendants).to eq({
        "AST::QueryNode()" => {
          "select_clause" => {
            "AST::SelectClauseNode()" => {
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
          "from_clause" => {
            "AST::FromClauseNode()" => {
              "table" => {
                "AST::TableNode(alias_name=)" => {
                  "table_def" => {
                    "AST::ExpressionNode(value=table)" => {}
                  }
                }
              }
            }
          },
          "where_clause" => nil,
        }
      })
    end

    it "generates the AST" do
      ast = described_class.new("SELECT * FROM table").do_parse
      expect(ast.self_and_descendants).to eq({
        "AST::QueryNode()" => {
          "select_clause" => {
            "AST::SelectClauseNode()" => {
              "selected_columns" => [
                {
                  "AST::SelectedColumnNode(alias_name=)" => {
                    "col_def" => {
                      "AST::ColumnNode(type=asterisk,name=)" => {}
                    }
                  }
                },
              ]
            }
          },
          "from_clause" => {
            "AST::FromClauseNode()" => {
              "table" => {
                "AST::TableNode(alias_name=)" => {
                  "table_def" => {
                    "AST::ExpressionNode(value=table)" => {}
                  }
                }
              }
            }
          },
          "where_clause" => nil,
        }
      })
    end
  end

  context "when query includes SELECT, FROM, WHERE statement" do
    it "generates the AST" do
      ast = described_class.new("SELECT name, address FROM table WHERE id = 12.5").do_parse
      expect(ast.self_and_descendants).to eq({
        "AST::QueryNode()" => {
          "select_clause" => {
            "AST::SelectClauseNode()" => {
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
              ]
            }
          },
          "from_clause" => {
            "AST::FromClauseNode()" => {
              "table" => {
                "AST::TableNode(alias_name=)" => {
                  "table_def" => {
                    "AST::ExpressionNode(value=table)" => {}
                  }
                }
              }
            }
          },
          "where_clause" => {
            "AST::WhereClauseNode()" => {
              "predicate" => [
                {
                  "AST::ConditionNode(operator=equals)" => {
                    "left" => {
                      "AST::SelectedColumnNode(alias_name=)" => {
                        "col_def" => {
                          "AST::ColumnNode(type=single_col,name=id)" => {}
                        }
                      }
                    },
                    "right" => {
                      "AST::ExpressionNode(value=12.5)" => {}
                    }
                  },
                }
              ]
            }
          },
        }
      })
    end
  end

  context "when a query includes COUNT function" do
    it "generates the AST" do
      ast = described_class.new("SELECT COUNT(*) FROM table WHERE id = 12").do_parse
      expect(ast.self_and_descendants).to eq({
        "AST::QueryNode()" => {
          "select_clause" => {
            "AST::SelectClauseNode()" => {
              "selected_columns" => [
                {
                  "AST::SelectedColumnNode(alias_name=)" => {
                    "col_def" => {
                      "AST::FunctionNode(type=count)" => {
                        "args" => [
                          "AST::ColumnNode(type=asterisk,name=)" => {}
                        ]
                      }
                    }
                  }
                }
              ]
            }
          },
          "from_clause" => {
            "AST::FromClauseNode()" => {
              "table" => {
                "AST::TableNode(alias_name=)" => {
                  "table_def" => {
                    "AST::ExpressionNode(value=table)" => {}
                  }
                }
              }
            }
          },
          "where_clause" => {
            "AST::WhereClauseNode()" => {
              "predicate" => [
                {
                  "AST::ConditionNode(operator=equals)" => {
                    "left" => {
                      "AST::SelectedColumnNode(alias_name=)" => {
                        "col_def" => {
                          "AST::ColumnNode(type=single_col,name=id)" => {}
                        }
                      }
                    },
                    "right" => {
                      "AST::ExpressionNode(value=12.0)" => {}
                    }
                  },
                }
              ]
            }
          },
        }
      })
    end
  end
end
