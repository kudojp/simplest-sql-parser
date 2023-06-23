module AST
  class Node; end # used as an abstract class

  # used for debugging.
  def self_and_descendants
    raise NotImplementedError.new("Implement #self_and_descendants in each node class!")
    # This method should return a hashmap
    # {
    #    "String which represents self" => {
    #      "child_attr_name1" => child_node_instance1.self_and_descendants,
    #      "child_attr_name2" => child_node_instance2.self_and_descendants,
    # }
  end
end

=begin
QueryNode.new
  @select: SelectStatementNode.new
    @columns: Array.new
      - SelectedColumnNode.new   # name
          @alias_name: String.new
          @col_def: ColumnNode.new
            @type: :single_col
            @name: "name"
      - SelectedColumnNode.new   # *
          @alias_name: String.new
          @col_def: ColumnNode.new
            @type: :asterisk
            @name: nil
      - SelectedColumnNode.new   # COUNT(name)
          @alias_name: String.new
          @col_def: FunctionNode.new
            @type: :count
            @args: Array.new
              - ColumnNode.new
                @type: :single_col
                @name: "name"
  @from: FromStatementNode.new
    @table: TableNode.new
      @table_def: ExpressionNode.new
      @alias_name: String.new
 @where: WhereStatementNode.new
    @predicate: EqualsPredicateNode.new (< PredicateNode)
      @left: ExpressionNode.new
      @right: ExpressionNode.new

Maybe,,
- I should create separate classes for each ExpressionNode depending on where it is used??
- I should create a parent class `StatementNode` for SelectStatementNode, FromStatementNode, and WhereStatementNode.
=end
