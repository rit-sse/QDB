#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'sshkit/dsl'
require 'highline/import'

Qdb2::Application.load_tasks

SSHKit.config.command_map[:bundle] = "/.rbenv/shims/bundle"
SSHKit.config.command_map[:rake] = "/.rbenv/shims/rake"

host = "web.ad.sofse.org"

task :deploy do
  user = ask("Enter username for #{host}:")
  on %W{#{user}@#{host}} do
    within "/QDB" do
      with rails_env: 'production' do
        execute :git, 'pull'
        execute 'bundle', '--without development:test', 'install'
        rake 'db:migrate'
        rake 'assets:precompile'
        rake 'start_server'
      end
    end
  end
end

namespace :server do

  task :start do
    if File.exists?('tmp/pids/unicorn.pid')
      pid = File.read('tmp/pids/unicorn.pid').to_i
      Process.kill("HUP", pid)
      puts 'Restarted the server'
    else
      puts 'Not running, starting the server...'
      sh 'unicorn -c config/unicorn.rb -E production -D'
    end
  end

  task :stop do
    if File.exists?('tmp/pids/unicorn.pid')
      pid = File.read('tmp/pids/unicorn.pid').to_i
      Process.kill("QUIT", pid)
      puts 'Stopped the server'
    else
      puts 'Server already down'
    end
  end

end