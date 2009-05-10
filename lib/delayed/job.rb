require File.dirname(__FILE__) + '/job/common'
require File.dirname(__FILE__) + (defined?(DataMapper) ? '/job/data_mapper' : '/job/active_record')
