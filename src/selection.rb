class Selection
  def initialize(child, &block)
    @block = block
    @child = child
  end

  def next
    while (value = @child.next)
      break if @block.call(value)
    end

    value
  end
end
