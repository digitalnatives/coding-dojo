require 'resque/tasks'

namespace :resque do

  desc 'setup resque'
  task 'setup' => :environment do
    # http://stackoverflow.com/questions/7807733/resque-worker-failing-with-postgresql-server/7846127#7846127
    Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
  end

end
