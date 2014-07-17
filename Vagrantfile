# -*- mode: ruby -*-
# vi: set ft=ruby :

# Loads in development environment variables, as a hash,
# from the .env file. This lets us share that file between
# direct, on the machine dev environments (which are probably
# faster and nicer for day to day development) and Vagrant
# backed dev environments, which are nicer for larger tests
# and docker tests.
# NOTE: Requires the vagrant plugin "dotenv" to be installed.
begin
  require 'dotenv'
  development_env = Dotenv::Parser.call(File.read(File.expand_path('.env')))
rescue LoadError; end

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "postgres" do |pg|
    pg.vm.provider "docker" do |d|
      d.name = 'postgres'
      d.env = development_env
      d.build_dir = "./docker/postgres"
      d.vagrant_vagrantfile = "docker/Vagrantfile"
    end
  end

  config.vm.define "joatu-rails" do |joatu|
    joatu.vm.provider "docker" do |d|
      d.name = 'joatu-rails'
      d.build_dir = "."
      d.env = development_env
      d.link("postgres")
      d.vagrant_vagrantfile = "docker/Vagrantfile"
    end
  end
end
