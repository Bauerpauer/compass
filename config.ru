#!/usr/bin/env ruby

ENV["ENVIRONMENT"] ||= "development"
require "lib/compass"

# View::cache_templates!

services = Harbor::Container.new

# Compass.services.register("mailer", Harbor::Mailer)
# Compass.services.register("mail_server", Harbor::SendmailServer)

DataMapper.setup :default, "sqlite3://#{Pathname(__FILE__).dirname.expand_path + "compass.db"}"
# DataMapper.setup :search, "ferret:///tmp/compass.sock"

if $0 == __FILE__
  require "harbor/console"
  Harbor::Console.start
elsif $0['thin']
  run Harbor::Cascade.new(
    ENV['ENVIRONMENT'],
    services,
    Compass
  )
else $0['rake']
  # Require rake tasks here
  # require "some/rake/tasks"
end
