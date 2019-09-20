class Sort
  # Only support 1 column sorting for now
  def initialize(child, column)
    @child = child
    @schema = %w[movieId title genres]
    @column_index = @schema.index(column)
    @unsorted_list = []
    @sorted_list = nil

    while (value = @child.next)
      @unsorted_list << value
    end

    if @sorted_list.nil?
      @sorted_list = @unsorted_list.sort_by { |record| record[@column_index] }
    end
  end

  def next
    # TODO: use more efficient data structure
    @sorted_list.length.zero? ? nil : @sorted_list.shift
  end
end