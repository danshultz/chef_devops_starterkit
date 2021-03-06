current_dir = File.dirname(__FILE__)
chef_dir = File.expand_path("#{current_dir}/../chef")
cookbook_path            ["#{chef_dir}/cookbooks"]

log_level                :info
log_location             STDOUT
syntax_check_cache_path  "#{current_dir}/syntax_check_cache"
