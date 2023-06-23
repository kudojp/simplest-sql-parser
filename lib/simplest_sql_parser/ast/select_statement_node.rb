require_relative "node"

module AST
  class SelectStatementNode < Node
    attr_reader :selected_columns

    def initialize(selected_columns:)
      @selected_columns = selected_columns # array of ColumnNode instances
    end

    def self_and_descendants
      descendants = @selected_columns.map do |column|
        column&.self_and_descendants
      end
      { "#{self.class}" => {"selected_columns" => descendants} }
    end
  end
end
