$LOAD_PATH << File.expand_path('../../../lib' , __FILE__)
require 'lottery'

module MyCucumber
  TEST_DATA_FOLDER = File.join(File.expand_path("../../../", __FILE__), "test_data","folder")
end
