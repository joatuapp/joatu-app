VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "postgres" do |pg|
    pg.vm.provider "docker" do |d|
      d.name = 'postgres'
      d.env = {"POSTGRESQL_USER" => "joatu", "POSTGRESQL_PASS" => "joatu-dev-pass"}
      d.build_dir = "./docker/postgres"
      d.vagrant_vagrantfile = "docker/Vagrantfile"
    end
  end

  # config.vm.provider "docker" do |d|
    # d.name = 'joatu-rails'
    # d.build_dir = "."
  # end

  # need a private network for NFS shares to work
  # config.vm.network "private_network", ip: "192.168.50.4"

  # Rails Server Port Forwarding
  # config.vm.network "forwarded_port", guest: 3000, host: 3000

  # config.vm.provision "shell", inline: "apt-get -y update"

  # Install latest docker
  # config.vm.provision "docker"

  # Must use NFS for this otherwise rails
  # performance will be awful
  # config.vm.synced_folder ".", "/app", type: "nfs"

  # Setup the containers when the VM is first
  # created
  # config.vm.provision "shell", inline: $setup

  # Make sure the correct containers are running
  # every time we start the VM.
  # config.vm.provision "shell", run: "always", inline: $start
end
