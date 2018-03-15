# frozen_string_literal: true
require 'resque/tasks'

namespace :resque do
  task setup: :environment do
    Resque.before_fork do
      ActiveRecord::Base.connection_pool.disconnect!
      ActiveRecord::Base.connection.disconnect!
    end

    Resque.after_fork do
      ActiveRecord::Base.establish_connection
    end
  end
end

desc 'Alias for standardized entry'
task 'jobs:work' => 'resque:work'
