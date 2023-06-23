require_relative "node"

module AST
  class SelectedColumnNode < Node
    attr_reader :col_def

    def initialize(col_def:, alias_name: nil)
      @col_def = col_def
      @alias_name = alias_name

    end

    def self_and_descendants
      {
        "#{self.class}(alias_name=#{@alias_name})" => {
          "col_def" => @col_def&.self_and_descendants
        }
      }
    end
  end
end
