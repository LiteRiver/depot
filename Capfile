# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require "capistrano/rvm"
# require "capistrano/chruby"
require 'capistrano/rbenv'
require 'capistrano/puma'
require 'capistrano/bundler'
require 'capistrano/rails/assets'

install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Systemd
install_plugin Capistrano::Puma::Workers
# install_plugin Capistrano::Puma::Monit
install_plugin Capistrano::Puma::Nginx

set :rbenv_type, :user
set :rbenv_custom_path, '/usr/local/.rbenv'
set :rbenv_ruby, File.read('.ruby-version').strip
# set :rbenv_prefix,
#     "RBENV_ROOT=#{fetch(:rbenv_custom_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_custom_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }