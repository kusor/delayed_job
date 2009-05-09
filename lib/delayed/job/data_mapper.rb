# Prevent problem with extlib 0.9.11:
# extlib-0.9.11 NameError: method `to_time' not defined in Time
# http://groups.google.com/group/datamapper/browse_thread/thread/98f9a69dca23d80
gem 'extlib', '>= 0.9.12'
require 'extlib'

require 'dm-aggregates'
require 'dm-timestamps'

module Delayed
  class Job
    include DataMapper::Resource
    
    storage_names[:default]='delayed_jobs'
    
    property :id, Serial
    property :priority, Integer, :default => 0
    property :attempts, Integer, :default => 0
    property :handler, Text, :lazy => false
    property :last_error, Text, :lazy => false
    property :run_at, Time
    property :locked_at, Time, :default => nil, :nullable => true
    property :locked_by, String
    property :failed_at, Time, :default => nil, :nullable => true
    property :created_at, DateTime
    property :updated_at, DateTime
    
    def self.update_all(with, from)
      repository(:default).adapter.execute("UPDATE #{storage_names[:default]} SET #{Array(with)[0]} WHERE #{Array(from)[0]}", *Array(with)[1..-1].concat(Array(from)[1..-1])).affected_rows
    end
    
    def self.delete_all
      all.destroy!
    end
    
    def self.last
      all.last
    end
    
    def logger
      DataMapper.logger
    end
    
    def self.logger
      DataMapper.logger
    end
    
    def self.db_time_now
      Time.now
    end

    before(:save) { self.run_at ||= self.class.db_time_now }
    
    include Common
  end
end

#Place holder for type checking
module ActiveRecord
  module Base
    def self.default_timezone
      :boo
    end
  end
  module RecordNotFound; end
end