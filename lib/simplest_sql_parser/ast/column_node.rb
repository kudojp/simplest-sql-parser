require_relative "node"

module AST
  class ColumnNode < Node
    attr_reader :col_def

    def initialize(col_def:)
      @col_def = col_def # instance of ExpressionNode
    end

    def self_and_descendants
      {
        "#{self.class}" => {
          "col_def" => @col_def&.self_and_descendants
        }
      }
    end
  end
end
