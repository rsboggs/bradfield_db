module DataTypes
  class Schema

    attr_reader :fields

    def initialize(table:)
      @fields = %w[movieId title genres] # TODO: lookup based on table
      @types = [
        ::DataTypes::Long.new(),
        ::DataTypes::Char.new(255),
        ::DataTypes::Char.new(255)
      ]
    end
  end
end
