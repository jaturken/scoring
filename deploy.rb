#!/usr/bin/env ruby

# A quick deployment script using rsync, just define FROM, SERVER, and TO
# HOW TO USE:
# 1. set FROM, SERVER, and TO
# 2. run : chmod 755 deploy.rb
# 3. you can add post deploy tasks at the bottom
# 4. ./deploy.rb

# the location of the project
# you can also manually input the path:
# EX: FROM = "~/Sites/mysite"
FROM = File.dirname(__FILE__)
# the ip or hostname of the server, can use the following conventions for this variable:
#   - server_name # => if you have server_name setup in ~/.ssh/config
#   - username@host
SERVER = "scoring@198.20.105.55"
# the location on the server don't forget to append the slash/
TO = "app/"

## convenience helper methods

  def has_git?
    File.exists?(".git")
  end

  def has_git_ignores?
    File.exists?(".gitignore")
  end

  def exclusions
    return "" if !has_git_ignores? || !has_git?
    exclusions = `cat .gitignore`.split("\n")
    exclude_list = exclusions.map { |e| "--exclude '#{e}' " }
    exclude_list = exclude_list.join
  end

  # terminal column width
  def col_width
    `stty size`.split(" ").last.to_i
  end
## convenience helper methods
def pre_deploy
  ## PRE DEPLOYMENT Tasks below ##
  # EX: system("ssh #{SERVER} mkdir #{TO}/public/cache")
end
def deploy
  puts("Starting deployment...")
  # use -avzC to exclude .git and .svn repositories
  cmd = "rsync -avzC #{FROM} #{SERVER}:#{TO} #{exclusions}"
  output = "OUTPUT: #{cmd}"
  border = "="*col_width
  puts("#{border}\n#{output}\n#{border}")
  system(cmd)
end
def post_deploy
  ## POST DEPLOYMENT Tasks below ##
  # EX: system("ssh #{SERVER} chmod -R 755 #{TO}/public/cache")
end
pre_deploy
deploy
post_deploy
puts("Deployment Completed!...")
