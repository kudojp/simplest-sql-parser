# ref. https://github.com/tenderlove/rexical/blob/master/DOCUMENTATION.ja.rdoc

class SimplestSqlParser::LexicalScanner
option
  ignorecase
macro
  BLANK \s+
  WORD [a-zA-Z]\w*
  NUMBER \d+(\.\d+)?
rule
  {BLANK}   # do nothing

  # keywords
  ## keyword of statements
  SELECT { [:select, text] }
  FROM { [:from, text] }
  WHERE { [:where, text] }

  ## keyword of functions
  COUNT { [:count, text] }

  # tokens
  ,   { [:comma, text] }
  \*   { [:asterisk, text] }
  =   {[:equals, text]}
  \(   {[:parenthesis_right, text]}
  \)   {[:parenthesis_left, text]}

  # identifiers
  {WORD} { [:identifier, text] }
  {NUMBER} {[:identifier, text.to_f]}
