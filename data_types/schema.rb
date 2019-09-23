module DataTypes
  class Schema
    attr_reader :fields, :types, :table_file_name

    def initialize(table:)
      # extract the lookup
      case table
      when "movies"
        @fields = %w[movieId title genres]
        @types = [
          ::DataTypes::Long.new(),
          ::DataTypes::Char.new(255),
          ::DataTypes::Char.new(255)
        ]
        @table_file_name = "test/data/movies_test.bin"
      when "ratings"
        @fields = %w[id userId movieId rating]
        @types = [
          ::DataTypes::Long.new(),
          ::DataTypes::Long.new(),
          ::DataTypes::Long.new(),
          ::DataTypes::Long.new(),
        ]
        @table_file_name = "test/data/ratings_test.bin"
      else
        raise NotImplementedError
      end
    end
  end
end
