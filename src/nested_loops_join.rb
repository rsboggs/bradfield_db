module Src
  class NestedLoopsJoin
    def initialize(child1:, child2:, table1:, table2:, column1:, column2:)
      @child1 = child1
      @child2 = child2
      @table1 = table1
      @table2 = table2

      @schema1 = ::DataTypes::Schema.new(table: @table1)
      @schema2 = ::DataTypes::Schema.new(table: @table2)

      # Only support joining on 1 column for now
      @table1_index = @schema1.fields.index(column1)
      @table2_index = @schema2.fields.index(column2)

      setup_next_file_scan
    end

    def next
      while @record1
        while @record2
          if @record1[@table1_index] == @record2[@table2_index]
            value = [@record1, @record2]
            @record2 = @child2.next
            return value
          end

          @record2 = @child2.next
        end

        setup_next_file_scan
      end

      nil
    end

    private

    def setup_next_file_scan
      @child2.reset
      @record1 = @child1.next
      @record2 = @child2.next
    end
  end
end
