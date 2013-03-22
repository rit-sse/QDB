pid = `pgrep -lf unicorn_rails`[/\d*/]
puts "Pid: #{pid}"

system("kill -9 #{pid}")
puts "Killed unicorn"
