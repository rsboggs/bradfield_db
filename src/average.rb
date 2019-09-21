class Average
  def initialize(child:, table:, column:)
    @child = child
    @schema = ::DataTypes::Schema.new(table: table)
    @column_index = @schema.fields.index(column)
    @running_sum = 0
    @running_count = 0

    while (record = @child.next)
      @running_sum += record[@column_index]
      @running_count += 1
    end
  end

  def next
    return nil if @running_count.zero?

    value = @running_sum / @running_count
    reset_running_totals
    value
  end

  private

  def reset_running_totals
    @running_count = 0
    @running_sum = 0
  end
end
