require_relative "../file_wrapper/table_reader"

class FileScan
  def initialize
    @fw = FileWrapper::TableReader.new
  end

  def next
    @fw.next_record
  end
end
