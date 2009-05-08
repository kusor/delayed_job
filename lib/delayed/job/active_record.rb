module Delayed
  class Job < ActiveRecord::Base    
    set_table_name :delayed_jobs
    
    include Common
    
    def self.db_time_now
      (ActiveRecord::Base.default_timezone == :utc) ? Time.now.utc : Time.now
    end
    
  protected
    def before_save
      self.run_at ||= self.class.db_time_now
    end
  end
end
#Place holder for type checking
module DataMapper
  module Resource; end
  module ObjectNotFoundError; end
end