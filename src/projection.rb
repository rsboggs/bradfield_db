class Projection
  def initialize(child:, table:, columns:)
    @child = child
    @schema = ::DataTypes::Schema.new(table: table)
    @filtered_column_indexes = columns.each_with_object(Hash.new(false)) do |value, out|
      index = @schema.fields.index(value)
      out[index] = true
    end
  end

  def next
    values = @child.next

    filtered_values(values) if values
  end

  private

  def filtered_values(values)
    current_index = 0
    values.inject([]) do |out, value|
      out << value if @filtered_column_indexes[current_index]
      current_index += 1
      out
    end
  end
end
