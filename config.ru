# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
map '/qdb' do
  run Qdb2::Application
end
