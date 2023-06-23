require_relative "node"

module AST
  class TableNode < Node
    attr_reader :table_def
    attr_reader :alias_name

    def initialize(table_def:, alias_name: nil)
      @table_def = table_def # For now, this is ExpressionNode
      @alias_name = alias_name
    end

    def list_attributes_without_child
      [:alias_name]
    end

    def list_attributes_of_single_child_node
      [:table_def]
    end
  end
end
