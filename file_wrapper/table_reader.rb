require_relative "base"
require_relative "../data_types/long"
require_relative "../data_types/char"
require_relative "../data_types/schema"

module FileWrapper
  class TableReader
    def initialize(table_name: "data/movies.bin")
      @file_wrapper = FileWrapper::Base.new(table_file: table_name)
      @schema = Schema.new([
        ["movie_id", ::DataTypes::Long.new],
        ["title", ::DataTypes::Char.new(255)],
        ["genres", ::DataTypes::Char.new(255)],
      ])
    end

    def next_record
      return nil if @file_wrapper.end_of_file?

      record = []
      # TODO: fix
      # @schema.fields.each do |type|
      #   record << self.send("next_#{type.downcase}")
      # end
      record
    end


  end
end
