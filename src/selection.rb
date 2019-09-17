class Selection
  OPERATORS = {
    EQUALS: "==",
    GREATER_THAN: ">",
    LESS_THAN: "<",
    GREATER_THAN_OR_EQUAL: ">=",
    LESS_THAN_TO_OR_EQUAL: "<=",
  }.freeze

  def initialize(child, filters)
    @child = child
    @schema = %w[movieId title genres]
    @column, @operator, @value = filters
  end

  def next
    while (record = @child.next)
      break if is_match?(record)
    end

    record
  end

  def is_match?(record)
    column_index = @schema.index(@column)
    record[column_index].public_send(OPERATORS[@operator.to_sym], @value)
  end
end
