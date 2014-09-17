# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'JoatU'
set :repo_url, 'git@github.com:joatuapp/joatu-app.git'

# Deploy using the deploy user.
set :user, 'deploy'

# Configure rbenv
set :rbenv_ruby, `cat #{File.join(File.dirname(__FILE__), "../", '.ruby-version')}`.chomp
set :rbenv_custom_path, "/opt/rbenv"

set :ci_client, "travis"
set :ci_repository, "joatuapp/joatu-app"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{.rbenv-vars}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

before 'deploy', 'ci:verify'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      if test("[ -f #{shared_path.join("tmp/pids/unicorn.pid")} ]")
        execute :kill, "-USR2 #{capture(:cat, shared_path.join("tmp/pids/unicorn.pid"))}"
      else
        execute :sudo, "start joatu_app"
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
