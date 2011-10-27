require 'spec/rake/spectask'
desc "Run specs, run a specific spec with TASK=spec/path_to_spec.rb. By default the tests are run with ActiveRecord, set DM=true to run the tests with DataMapper."
task :spec => [ "spec:default" ]

namespace :spec do
  OPTS_FILENAME = "./spec/spec.opts"
  if File.exist?(OPTS_FILENAME)
    SPEC_OPTS = ["--options", OPTS_FILENAME]
  else
    SPEC_OPTS = ["--color", "--format", "specdoc"]
  end

  Spec::Rake::SpecTask.new('default') do |t|
    t.spec_opts = SPEC_OPTS
    if(ENV['TASK'])
      t.spec_files = [ENV['TASK']]
    else
      t.spec_files = Dir['spec/*_spec.rb'].sort
    end
  end
end