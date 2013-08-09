
base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir  = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")
support_dir = File.join(test_dir, "support")

$LOAD_PATH.unshift(lib_dir)
$LOAD_PATH.unshift(support_dir)

require 'test/unit'

exit Test::Unit::AutoRunner.run(true, test_dir)
