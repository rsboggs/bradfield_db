class Distinct
  def initialize(child, column)
    @child = child
    @schema = %w[movieId title genres]
    @last_value = nil
    @column_index = @schema.index(column)
  end

  def next
    while (record = @child.next)
      if record[@column_index] != @last_value
        @last_value = record[@column_index]
        break
      end
    end

    record.nil? ? nil : record[@column_index]
  end
end
