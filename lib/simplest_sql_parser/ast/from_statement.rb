require_relative "node"

module AST
  class FromStatementNode
    attr_reader :table
    def initialize(table:)
      @table = table
    end

    def self_and_descendants
      {
        "#{self.class}" => {
          "table" => @table&.self_and_descendants
        }
      }
    end
  end
end
