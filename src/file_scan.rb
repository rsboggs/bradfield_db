require_relative "../file_wrapper/table_reader"

class FileScan
  def initialize(table:)
    @fw = FileWrapper::TableReader.new(table: table)
  end

  def next
    @fw.next_record
  end
end
