require_relative "../file_wrapper/table_reader"

class FileScan
  def initialize(table_file_name:, table:)
    @fw = FileWrapper::TableReader.new(table_file_name: table_file_name, table: table)
  end

  def next
    @fw.next_record
  end
end
