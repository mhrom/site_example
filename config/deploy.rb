#Add stages to capistrano
require 'capistrano/ext/multistage'
require "capistrano-config"

#set :config_files, ["config/config.yml"]

# Load DSL and Setup Up Stages
#require 'capistrano/setup'

# Includes default deployment tasks
#require 'capistrano/deploy'

set :user, "deploy"
#ssh options shared among servers and enviroments
set :ssh_options, {
  user: fetch(:user),
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey),
  port: 22
}

default_run_options[:pty] = true

#eviroment related variables
set :stages, ["staging", "production","qa"]
set :default_stage, "qa"

#global variables related to application 

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
#CVS global settings
set :scm, :git
set :repository,  "git@github.com:mhrom/site_example.git"
set :scm_command, "/usr/b/ingit"
set :branch, 'master'
set :scm_verbose, true

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

#Dir.glob('config/deploy/recipes/*.rb').each { |recipe| load recipe }
#after 'deploy:update', 'deploy:link_live'
