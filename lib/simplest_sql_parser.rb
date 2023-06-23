# frozen_string_literal: true

require_relative "simplest_sql_parser/version"
require_relative "simplest_sql_parser/lexical_scanner.rex.rb"
require_relative "simplest_sql_parser/parser.tab.rb"
Dir[File.join(File.dirname(__FILE__), "simplest_sql_parser/ast/*.rb")].each {|file| require file }

module SimplestSqlParser
  class Error < StandardError; end
  # Your code goes here...
end
