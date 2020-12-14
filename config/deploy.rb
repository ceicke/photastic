# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'photastic'
set :repo_url, 'git@github.com:ceicke/photastic.git'
set :rvm_ruby_version, 'ruby-2.3.0@photastic'

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
  desc 'restart puma'
  task :restart_puma do
    on roles(:web) do
      within release_path do
        execute 'source ~/config/secrets.sh'
        execute :bundle, :exec, 'pumactl -S /tmp/puma.state -p /tmp/puma.pid phased-restart'
      end
    end
  end

  after :finished, :restart_puma
end
