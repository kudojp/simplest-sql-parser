require_relative "node"

module AST
  class ExpressionNode < Node
    def initialize(value:)
      @value = value
    end
    def self_and_descendants
      { "#{self.class}(value=#{@value})" => {} }
    end
  end
end
