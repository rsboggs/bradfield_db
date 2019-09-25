require "require_all"
require "minitest/autorun"
require "mocha/mini_test"
require "pry"
require_all "data_types"
require_all "src"
require_all "file_wrapper"
require_all "test/support"

class Test < Minitest::Test
end
