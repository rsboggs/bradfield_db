class Selection

  def initialize(data, &block)
    @block = block
    @scan = Scan.new(data)
  end

  def next
    while (value = @scan.next)
      break if @block.call(value)
    end

    value
  end

  def close
    @scan.close
  end

end
