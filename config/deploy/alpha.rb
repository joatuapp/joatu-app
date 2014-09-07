# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.
# Note: chef_role is provided by the capistrano-chef gem, and lets us
# define roles based on a chef search.

public_ip_proc = Proc.new do |n|
  n["ec2"]["public_ipv4"]
end

chef_role [:web, :app], 'roles:rails AND chef_environment:alpha', attribute: public_ip_proc
chef_role :db, 'roles:postgresql AND chef_environment:alpha', attribute: public_ip_proc

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/data/web/joatu_alpha'

# Set rails env:
set :rails_env, :production

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

# server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
