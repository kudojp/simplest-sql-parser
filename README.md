# SimplestSqlParser

SimplestSqlParser is a simplest SQL parser written in Ruby.
Currently it parses queries only with `SELECT`, `FROM`, and `WHERE`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simplest_sql_parser'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install simplest_sql_parser

## Usage

TODO: Write usage instructions here

## Development

To update the lex scanner `SimplestSQLParser::LexicalScanner`,
1. Update `lib/simplest_sql_parser/lexical_scanner.rex`
2. Run $`bundle exec rex lib/simplest_sql_parser/lexical_scanner.rex`

To update the parser `SimplestSQLParser::Parser`,
1. Update `lib/simplest_sql_parser/parser.racc`
2. Run $`bundle exec racc lib/simplest_sql_parser/parser.rex`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simplest_sql_parser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/simplest_sql_parser/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SimplestSqlParser project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/simplest_sql_parser/blob/master/CODE_OF_CONDUCT.md).
