Vagrant.configure("2") do |config|
  ## Choose your base box
  config.vm.box = "saucy64-lxc"

  #config.vm.provider :virtualbox do |vb|
  #  vb.customize ["modifyvm", :id, "--memory", 22000]
  #  vb.customize ["modifyvm", :id, "--cpus", 4]
  #end

  config.vm.provider :lxc do |lxc|
    lxc.customize 'cgroup.memory.limit_in_bytes', '22G'
  end

  ## Forward SSH agent
  config.ssh.forward_agent = true

  ## For masterless, mount your file roots file root
  config.vm.synced_folder "salt/roots/", "/srv/"

  ## Setup shared folder to my usual git repos
  config.vm.synced_folder "../../scikit_learn_data", "/home/vagrant/scikit_learn_data"
  config.vm.synced_folder "../../code", "/home/vagrant/code"
  config.vm.synced_folder "../../data", "/home/vagrant/data"

  ## Forward the default IPython notebook port on the guest
  ## to the host
  config.vm.network :forwarded_port, guest: 8888, host: 18888

  ## Set your salt configs here
  config.vm.provision :salt do |salt|

    ## Minion config is set to ``file_client: local`` for masterless
    salt.minion_config = "salt/minion"

    ## Installs our example formula in "salt/roots/salt"
    salt.run_highstate = true

    ## Display salt highstate output
    salt.verbose = true

  end
end
