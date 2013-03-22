pid = `pgrep -lf unicorn_rails`[/\d*/]
puts "Pid: #{pid}"

system("kill -9 #{pid}")
puts "Killed unicorn"

`unicorn_rails -c config/unicorn.rb -D -E production`
puts "unicorn up and running again"
