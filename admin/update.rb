pid = `pgrep -lf unicorn_rails`[/\d*/]
puts "Pid: #{pid}"

system("kill -9 #{pid}")
puts "Killed unicorn"

#puts "pulling"
#`git pull`

puts "bundle install"
`bundle install`

puts "assets compiling"
`rake assets:precompile`

`unicorn_rails -c config/unicorn.rb -D -E production`
puts "unicorn up and running again"
