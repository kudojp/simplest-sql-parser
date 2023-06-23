require_relative "node"

module AST
  class ExpressionNode < Node
    def initialize(value:)
      @value = value
    end
    def self_and_descendants
      { "ExpressionNode(value=#{@value})" => {} }
    end
  end
end
