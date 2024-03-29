# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'photastic'
set :repo_url, 'git@github.com:ceicke/photastic.git'
set :rvm_ruby_version, 'ruby-2.6.3@photastic'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/photastic/app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc 'Restart Passenger'
  task :restart_passenger do
    on roles(:app) do
      execute '/usr/bin/passenger-config restart-app /home/photastic/app/current'
    end
  end
end

after 'deploy:publishing', 'deploy:restart_passenger'
