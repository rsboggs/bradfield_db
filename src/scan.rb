class Scan
  def initialize(data)
    @queue = Queue.new
    data.each do |datum|
      @queue << datum
    end
  end

  def next
    return nil if @queue.empty?

    @queue.pop
  end

  def close
    @queue.close
  end
end
