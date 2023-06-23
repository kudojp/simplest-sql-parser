require './lib/simplest_sql_parser/lexical_scanner.rex'

RSpec.describe SimplestSqlParser::LexicalScanner do
  let(:scanner){ described_class.new() }

  context "when a query includes SELECT, FROM statements" do
    it "tokenizes the query" do
      scanner.scan_setup("SELECT name FROM table")
      expect(scanner.next_token).to eq [:select, "SELECT"]
      expect(scanner.next_token).to eq [:identifier, "name"]
      expect(scanner.next_token).to eq [:from, "FROM"]
      expect(scanner.next_token).to eq [:identifier, "table"]
      expect(scanner.next_token).to eq nil
    end

    it "tokenizes the query" do
      scanner.scan_setup("SELECT name, address FROM table")
      expect(scanner.next_token).to eq [:select, "SELECT"]
      expect(scanner.next_token).to eq [:identifier, "name"]
      expect(scanner.next_token).to eq [:comma, ","]
      expect(scanner.next_token).to eq [:identifier, "address"]
      expect(scanner.next_token).to eq [:from, "FROM"]
      expect(scanner.next_token).to eq [:identifier, "table"]
      expect(scanner.next_token).to eq nil
    end

    it "tokenizes the query" do
      scanner.scan_setup("SELECT * FROM table")
      expect(scanner.next_token).to eq [:select, "SELECT"]
      expect(scanner.next_token).to eq [:asterisk, "*"]
      expect(scanner.next_token).to eq [:from, "FROM"]
      expect(scanner.next_token).to eq [:identifier, "table"]
      expect(scanner.next_token).to eq nil
    end
  end

  context "even when a keyword in a query is not capitalized" do
    it "tokenizes the query" do
      scanner.scan_setup("select name FRom table")
      expect(scanner.next_token).to eq [:select, "select"]
      expect(scanner.next_token).to eq [:identifier, "name"]
      expect(scanner.next_token).to eq [:from, "FRom"]
      expect(scanner.next_token).to eq [:identifier, "table"]
      expect(scanner.next_token).to eq nil
    end
  end

  context "when a query includes WHERE statement" do
    it "tokenizes the query" do
      scanner.scan_setup("SELECT name, address FROM table WHERE id = 12.5")
      expect(scanner.next_token).to eq [:select, "SELECT"]
      expect(scanner.next_token).to eq [:identifier, "name"]
      expect(scanner.next_token).to eq [:comma, ","]
      expect(scanner.next_token).to eq [:identifier, "address"]
      expect(scanner.next_token).to eq [:from, "FROM"]
      expect(scanner.next_token).to eq [:identifier, "table"]
      expect(scanner.next_token).to eq [:where, "WHERE"]
      expect(scanner.next_token).to eq [:identifier, "id"]
      expect(scanner.next_token).to eq [:equals, "="]
      expect(scanner.next_token).to eq [:identifier, 12.5]
      expect(scanner.next_token).to eq nil
    end
  end

  context "when a query includes COUNT function" do
    it "tokenizes the query" do
      scanner.scan_setup("SELECT COUNT(*) FROM table WHERE id = 12")
      expect(scanner.next_token).to eq [:select, "SELECT"]
      expect(scanner.next_token).to eq [:count, "COUNT"]
      expect(scanner.next_token).to eq [:parenthesis_right, "("]
      expect(scanner.next_token).to eq [:asterisk, "*"]
      expect(scanner.next_token).to eq [:parenthesis_left, ")"]
      expect(scanner.next_token).to eq [:from, "FROM"]
      expect(scanner.next_token).to eq [:identifier, "table"]
      expect(scanner.next_token).to eq [:where, "WHERE"]
      expect(scanner.next_token).to eq [:identifier, "id"]
      expect(scanner.next_token).to eq [:equals, "="]
      expect(scanner.next_token).to eq [:identifier, 12]
      expect(scanner.next_token).to eq nil
    end
  end
end
