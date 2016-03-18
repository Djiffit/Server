# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"
load 'faye/client_event.rb'

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "production")
PrivatePub.faye_app.add_extension(ClientEvent.new)
run PrivatePub.faye_app
