# frozen_string_literal: true

require_relative "simplest_sql_parser/version"
require_relative "simplest_sql_parser/lexical_scanner.rex.rb"
require_relative "simplest_sql_parser/parser.tab.rb"

module SimplestSqlParser
  class Error < StandardError; end
  # Your code goes here...
end
