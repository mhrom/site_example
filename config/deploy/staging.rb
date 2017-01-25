#enviroment variables
server "node-2", :web2, :primary => true
set :application, "django"
set :deploy_to, "/var/www/html/#{ application }"


#Restart webservers via capistrano
namespace :web2 do
  desc "Restart web servers"
  task :restart, :roles => :web do
    sudo "shutdown -r now"
  end
end
