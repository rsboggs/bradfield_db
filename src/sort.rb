class Sort
  # Only support 1 column sorting for now
  def initialize(child:, table:, column:)
    @child = child
    @schema = ::DataTypes::Schema.new(table: table)
    @column_index = @schema.fields.index(column)
    @unsorted_list = []
    @sorted_list = nil

    while (value = @child.next)
      @unsorted_list << value
    end
    return unless @sorted_list.nil?

    @sorted_list = @unsorted_list.sort_by { |record| record[@column_index] }
  end

  # TODO: Implement out of core sorting instead
  def next
    @sorted_list.empty? ? nil : @sorted_list.shift
  end
end
