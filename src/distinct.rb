class Distinct
  def initialize(child:, table:, column:)
    @child = child
    @schema = ::DataTypes::Schema.new(table: table)
    @column_index = @schema.fields.index(column)
    @last_value = nil
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
