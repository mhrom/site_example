load 'deploy'
# Uncomment if you are using Rails' asset pipeline
    # load 'deploy/assets'
load 'config/deploy' # remove this line to skip loading any of the default tasks
require_releative 'modules/utils/lib/helpers'
require_relative 'modules/hiera/lib/cap_hiera'
import 'modules/puppet/tasks/puppet.cap'

#Module specific variables
set :hiera_config 'config/hiera.yaml'
set :hiera_data 'files/hiera'
set :puppet_data, 'files/puppet'
