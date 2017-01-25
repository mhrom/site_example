#Enviroment variables 
server "node-1", :web, :primary => true
set :application, "django"
set :deploy_to, "/var/www/html/#{ application }"

#Change apache configuration file


#Setup custom tasks
namespace :prepare_envs do
  desc "Create shrared folder"
  task :create_tmp_folder, :roles => :web do
  puts "Create shared fodler in root of deployment folder"
  run "sudo mkdir #{ deploy_to }/tmp"
  end
	
  desc "Set permission for deploying folder"
  task :change_permission, :roles => :web do
  run "sudo chmod -R 777 #{ deploy_to } && sudo chown -R deploy:deploy #{ deploy_to}"
  end
  desc "Default task"
  
  task :default do
    create_tmp_folder
    change_permission
  end
end

before :create_tmp_folder, :change_permission

#Custom tasks to deploy standart flow
namespace :deploy do

  desc 'Link live symlink to latest release'
  task :link_live do
    puts " ** Linking live to latest releasen"
    run "ln -nfs #{ current_path } #{ deploy_to }/live"
 end
end

#Management tasks
namespace :management do
  desc "Restart web servers"
  task :restart, :roles => :web do
    puts "Restarting servers...."
    sudo "shutdown -r now"
  end
  
  desc "Shutdown web servers"
  task :shutdown, :roles => :web do
    puts "The servers are going to stop"
    sudo "shutdown -h now"
  end
  
  desc "Show uptime of servers"
  task :uptime, :roles => :web do
    sudo "uptime"
  end
  
  desc "Default task"
  task :default do
    uptime
    restart
  end
end


#set :branch, master
#set :branch, 'production'

=begin
set :branch do
  # Warn that branches cannot be deployed
  puts 'Cannot deploy a branch to production' unless fetch(:branch).nil?
 # Get the latest tags and set the default
  default = `git fetch --tags && git tag`.split("n").last
 
  # Allow the developer to choose a tag to deploy
  tag = Capistrano::CLI.ui.ask "Choose a tag to deploy (make sure to push the tag first): [Default: #{ default }] "
 
  # Fall back to the default if no tag was specified
  tag = default if tag.empty?
 
  # Be extra cautious and exit if a tag cannot be found
  if tag.nil?
    puts "Cannot deploy as no tag was found"
    exit
  end
 
  # Return the tag to deploy
  tag
end
=end
