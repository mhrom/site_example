#Enviroment variables 
server "node-3", :web3, :primary => true
set :application, "django"
set :deploy_to, "/var/www/html/#{ application }"

#Change apache configuration file

