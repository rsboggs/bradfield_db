class Selection
  OPERATORS = {
    EQUALS: "==",
    GREATER_THAN: ">",
    LESS_THAN: "<",
    GREATER_THAN_OR_EQUAL: ">=",
    LESS_THAN_TO_OR_EQUAL: "<=",
  }.freeze

  def initialize(child:, table:, filters:)
    @child = child
    @schema = ::DataTypes::Schema.new(table: table)
    @column, @operator, @value = filters
    @resolved_operator = OPERATORS[@operator.to_sym]
  end

  def next
    while (record = @child.next)
      break if is_match?(record)
    end

    record
  end

  def is_match?(record)
    column_index = @schema.fields.index(@column)
    record[column_index].public_send(@resolved_operator, @value)
  end
end
