require_relative "base"
require_relative "../data_types/long"
require_relative "../data_types/char"

module FileWrapper
  class TableReader
    def initialize(table_name: "data/movies.bin")
      @file_wrapper = FileWrapper::Base.new(table_file: table_name)
      @schema = %w[movieId title genres]
      @types = %w[Long Char Char]
    end

    def next_record
      return nil if @file_wrapper.end_of_file?

      record = []
      @types.each do |type|
        record << self.send("next_#{type.downcase}")
      end
      record
    end

    def next_long
      value = @file_wrapper.read(8)
      ::DataTypes::Long.new.from_binary(value)
    end

    def next_string
      string_length = next_long
      value = @file_wrapper.read(string_length * 8)
      ::DataTypes::Char.new.from_binary(value)
    end

  end
end
