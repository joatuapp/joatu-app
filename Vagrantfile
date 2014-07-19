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

  config.vm.box = "yungsang/boot2docker"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end
  
  # need a private network for NFS shares to work
  config.vm.network "private_network", ip: "192.168.50.4"

  # Rails Server Port Forwarding
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # Must use NFS for this otherwise rails
  # performance will be awful
  config.vm.synced_folder ".", "/var/www", type: "nfs"

  config.vm.provision "docker" do |d|
    d.pull_images 'undergroundwebdevelopment/postgres:9.3'
    d.build_image '/var/www', args: '-t joatu/joatu-app:dev'
    d.run "undergroundwebdevelopment/postgres:9.3", args: "--name='postgres'"
    d.run "joatu/joatu-app:dev", args: "--name='joatu-app' --link postgres:db"
  end
end
