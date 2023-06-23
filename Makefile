.PHONY: spec
spec: rex racc

.PHONY: rex
rex:
	bundle exec rex lib/simplest_sql_parser/lexical_scanner.rex
	bundle exec rspec spec/lexical_scanner_spec.rb

.PHONY: racc
racc:
	bundle exec racc lib/simplest_sql_parser/parser.racc &&\
	bundle exec rspec spec/parser_spec.rb
