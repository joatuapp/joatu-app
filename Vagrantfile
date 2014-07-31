# -*- mode: ruby -*-
# vi: set ft=ruby :

# Loads in development environment variables, as a hash,
# from the .env file. This lets us share that file between
# direct, on the machine dev environments (which are probably
# faster and nicer for day to day development) and Vagrant
# backed dev environments, which are nicer for larger tests
# and docker tests.
# NOTE: Requires the vagrant plugin "dotenv" to be installed.

development_env = {}
begin
  require 'dotenv'
  development_env = Dotenv::Parser.call(File.read(File.expand_path('.env')))
rescue LoadError; end
development_env["RAILS_ENV"] = "development"

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "docker" do |d|
    d.image             = "undergroundwebdevelopment/postgres:9.3"
    d.name              = "joatu_postgres"
    d.ports             = ['5432:5432']
  end

  config.vm.provider "docker" do |d|
    d.image           = "joatu/joatu-app:dev"
    d.name            = 'joatu-app'
    d.create_args     = ['-i', '-t']
    d.cmd             = ['/bin/bash', '-l']
    d.remains_running = false
    d.ports           = ['3000:3000']

    d.link('joatu_postgres:db')
  end
  config.vm.synced_folder ".", "/var/www", owner: 'web', group: 'web'
end
