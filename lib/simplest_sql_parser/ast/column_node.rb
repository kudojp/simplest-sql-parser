require_relative "node"

module AST
  class ColumnNode < Node
    class UnsupportedTypeError < StandardError; end

    TYPES = [:single_col, :asterisk].freeze
    attr_reader :type
    attr_reader :col_def

    def initialize(type: :single_col, name:)
      raise UnsupportedTypeError.new() unless TYPES.include? type
      @type = type # single_col
      @name = name # nil when type == :asterisk
    end

    def self_and_descendants
      {
        "#{self.class}(type=#{@type},name=#{@name})" => {}
      }
    end
  end
end
