require_relative "node"

module AST
  class QueryNode < Node
    attr_reader :select_statement
    attr_reader :from_statement
    attr_reader :where_statement

    def initialize(select_statement:nil, from_statement: nil, where_statement: nil)
      @select_statement = select_statement
      @from_statement = from_statement
      @where_statement = where_statement
    end

    def self_and_descendants
      {
        "#{self.class}" => {
          "select_statement" => @select_statement,
          "from_statement" => @from_statement,
          "where_statement" => @where_statement,
        }
      }
    end
  end
end
