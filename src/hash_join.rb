module Src
  class HashJoin
    def initialize(child1:, child2:, child1_index:, child2_index:)
      @child1 = child1
      @child2 = child2
      @child1_index = child1_index
      @child2_index = child2_index
      @hash = Hash.new { |out, k| out[k] = [] }

      while (record1 = @child1.next)
        key = record1[child1_index]
        bucket = @hash[key]
        bucket << record1
      end
      @current_index = 0
      @record2 = @child2.next
    end

    def next
      while @record2
        key = @record2[@child2_index]
        while @hash[key].count.positive? && @current_index < @hash[key].count
          record1 = @hash[key][@current_index]
          @current_index += 1
          return record1 + @record2
        end

        @record2 = @child2.next
        @current_index = 0
      end
    end
  end
end
