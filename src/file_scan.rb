require_relative "../file_wrapper/table_reader"

class FileScan
  def initialize(table:)
    @table = table
    reset
  end

  def next
    @fw.next
  end

  def reset
    @fw = FileWrapper::TableReader.new(table: @table)
  end
end
