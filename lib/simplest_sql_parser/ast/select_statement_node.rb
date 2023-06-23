require_relative "node"

module AST
  class SelectStatementNode < Node
    attr_reader :columns

    def initialize(columns:)
      @columns = columns # array of ColumnNode instances
    end

    def self_and_descendants
      descendants = @columns.map do |column|
        column&.self_and_descendants
      end
      { "#{self.class}" => {"columns" => descendants} }
    end
  end
end
