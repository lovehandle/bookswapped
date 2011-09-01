# main details
set :application, "bookswapped"

role :web, "spubooks.com"
role :app, "spubooks.com"
role :db,  "spubooks.com", :primary => true

# server details
ssh_options[:forward_agent] = true
default_run_options[:shell] = false

set :deploy_to, "/home/deploy/Projects/bookswapped"
set :deploy_via, :remote_cache
set :user, "deploy"
set :use_sudo, false

# repo details
set :scm, :git
set :user, "deploy"
set :repository, "git@github.com:rclosner/bookswapped.git"
set :branch, "master"
set :git_enable_submodules, 1

# runtime dependencies
depend :remote, :gem, "bundler"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{release_path}/app/assets/images/ #{release_path}/public/images"
  end

end

namespace :bundler do
  desc "Install for production"
  task :install, :roles => :app do
    run "cd #{release_path} && bundle install --production"
  end

end

after 'deploy:update_code', 'deploy:symlink_shared'
after 'deploy:update_code', 'bundler:install'
