module Src
  class NestedLoopsJoin
    def initialize(child1:, child2:, theta:)
      @child1 = child1
      @child2 = child2
      @theta = theta

      setup_next_file_scan
    end

    def next
      while @record1
        while @record2
          if @theta.call(@record1, @record2)
            value = @record1 + @record2
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
