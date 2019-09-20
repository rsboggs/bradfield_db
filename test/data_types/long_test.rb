require "./test/test"

module DataTypes
  class LongTest < Test
    def test_can_serialize_and_deserialize_long
      long_value = 567
      binary_value = "7\x02\x00\x00\x00\x00\x00\x00"

      assert_equal binary_value, ::DataTypes::Long.serialize(long_value)
      assert_equal long_value, ::DataTypes::Long.deserialize(binary_value)
    end
  end
end
