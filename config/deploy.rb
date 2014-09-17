# config valid only for Capistrano 3.1
lock '3.1.0'

def ask_secretly(key, default=nil)
  set key, proc {
    hint = default ? " [#{default}]" : ""
    answer = HighLine.new.ask("Enter server #{key}#{hint}: ") { |q| q.echo = false }.to_s
  }
end

set :application, 'blog-eye'
set :repo_url, "git@github.com:agilejzl/blog-eye.git"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/var/www/#{fetch(:application)}"

# Default value for :scm is :git
set :scm, :git
set :use_sudo, false
# set :run_options, { pty: true }
set :ssh_options, { forward_agent: true }

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true
set :bundle_flags, '--deployment'

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/settings.yml config/sensitive.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{public/assets}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 3 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Some commands before publishing'
  task :rake_commands do
    on roles(:db), in: :groups, wait: 3 do
      within release_path do
        execute :rake, 'system:renew_max_notice_times RAILS_ENV=production'
      end
    end
  end

  before :publishing, :rake_commands

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 3 do
      # Here we can do anything such as:
    end
  end

end
