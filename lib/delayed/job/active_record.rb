module Delayed
  # A job object that is persisted to the database.
  # Contains the work object as a YAML field.
  class Job < ActiveRecord::Base    
    set_table_name :delayed_jobs
    
    include Common
    # Get the current time (GMT or local depending on DB)
    # Note: This does not ping the DB to get the time, so all your clients
    # must have syncronized clocks.
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