class FileScan
  def initialize(table:)
    @table = table
    reset
  end

  def next
    @table_base.next_record
  end

  def reset
    @table_base = ::Table::Base.new(table: @table)
  end
end
