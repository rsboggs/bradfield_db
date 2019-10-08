require "./test/test"

module Src
  class FileScanTest < Minitest::Test
    def setup
      ::Support::Helper.setup_test_data("movies")
      ::Support::Helper.setup_test_data("ratings")
    end

    def teardown
      ::Support::Helper.teardown_test_data("movies")
      ::Support::Helper.teardown_test_data("ratings")
    end

    def test_can_reset
      @scan = ::FileScan.new(table: "movies")

      assert_equal [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"], @scan.next
      assert_equal [2, "Jumanji (1995)", "Adventure|Children|Fantasy"], @scan.next
      assert_equal [3, "Grumpier Old Men (1995)", "Comedy|Romance"], @scan.next

      @scan.reset
      check_scan
    end

    def test_can_reset_for_other_table
      @scan = ::FileScan.new(table: "ratings")

      assert_equal [1, 80_766, 1, 5], @scan.next

      @scan.reset
      check_scan_ratings
    end

    private

    def check_scan
      assert_equal [1, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"], @scan.next
      assert_equal [2, "Jumanji (1995)", "Adventure|Children|Fantasy"], @scan.next
      assert_equal [3, "Grumpier Old Men (1995)", "Comedy|Romance"], @scan.next
      assert_equal [4, "Waiting to Exhale (1995)", "Comedy|Drama|Romance"], @scan.next
      assert_equal [5, "Father of the Bride Part II (1995)", "Comedy"], @scan.next
      assert_equal [6, "Heat (1995)", "Action|Crime|Thriller"], @scan.next
      assert_equal [7, "Sabrina (1995)", "Comedy|Romance"], @scan.next
      assert_equal [8, "Toy Story (1995)", "Adventure|Animation|Children|Comedy|Fantasy"], @scan.next
      assert_equal [9, "Sudden Death (1995)", "Action"], @scan.next
      assert_equal [10, "GoldenEye (1995)", "Action|Adventure|Thriller"], @scan.next
      assert_nil @scan.next
    end

    def check_scan_ratings
      assert_equal [1, 80_766, 1, 5], @scan.next
      assert_equal [2, 80_767, 1, 4], @scan.next
      assert_equal [3, 80_766, 2, 4], @scan.next
    end
  end
end
