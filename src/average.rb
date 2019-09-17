class Average
  def initialize(child, column)
    @child = child
    @schema = %w[movieId title genres]
    @column_index = @schema.index(column)
    @running_sum = 0
    @running_count = 0
  end

  def next
    record = @child.next
    return nil if record.nil?

    while (record)
      @running_sum += record[@column_index]
      @running_count += 1
      record = @child.next
    end

    @running_sum / @running_count
  end
end
