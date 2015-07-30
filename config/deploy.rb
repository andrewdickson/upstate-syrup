# config valid only for current version of Capistrano
lock '3.4.0'
set :application, 'syrup'                       # application name
set :repo_url, 'git@github.com:andrewdickson/upstate-syrup.git'   # your repo url
set :deploy_to, '/opt/syrup'

set :scm, :git
set :use_sudo, true
set :user, "ubuntu"

set :keep_releases, 999

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :passenger_restart_with_touch, true

role :web, "ubuntu@52.11.59.250"
role :app, "ubuntu@52.11.59.250"
role :db, "ubuntu@52.11.59.250", primary: true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart do ; end
end

