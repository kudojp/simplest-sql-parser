require_relative "node"

module AST
  class TableNode
    attr_reader :table_def
    attr_reader :alias

    def initialize(table_def:, alias_name: nil)
      @table_def = table_def # For now, this is ExpressionNode
      @alias_name = alias_name
    end

    def  self_and_descendants
      {
        "#{self.class}(alias_name=#{@alias_name})" => {
          "table_def" => @table_def.self_and_descendants,
        }
      }
    end
  end
end
