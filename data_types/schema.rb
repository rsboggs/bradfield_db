module DataTypes
  class Schema
    attr_reader :fields, :types

    def initialize(table:)
      # TODO: lookup based on table
      case table
      when "movies"
        @fields = %w[movieId title genres]
        @types = [
          ::DataTypes::Long.new(),
          ::DataTypes::Char.new(255),
          ::DataTypes::Char.new(255)
        ]
      when "ratings"
        @fields = %w[id userId movieId rating]
        @types = [
          ::DataTypes::Long.new(),
          ::DataTypes::Long.new(),
          ::DataTypes::Long.new(),
          ::DataTypes::Long.new(),
        ]
      else
        raise NotImplementedError
      end
    end
  end
end
