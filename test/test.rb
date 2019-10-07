require "require_all"
require "minitest/autorun"
require "mocha/minitest"
require "pry"
require_all "data_types"
require_all "src"
require_all "file_wrapper"
require_all "test/support"

class Test < Minitest::Test
end
