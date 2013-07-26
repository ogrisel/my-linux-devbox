Vagrant.configure("2") do |config|
  ## Choose your base box
  config.vm.box = "raring64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"

  ## Forward SSH agent
  config.ssh.forward_agent = true

  ## For masterless, mount your file roots file root
  config.vm.synced_folder "salt/roots/", "/srv/"

  ## Make the venvs visible from the host OS
  config.vm.synced_folder "venvs", "/home/vagrant/venvs"

  ## Setup shared folder to my work repos
  config.vm.synced_folder "../scikit-learn", "/home/vagrant/scikit-learn"
  config.vm.synced_folder "../joblib", "/home/vagrant/joblib"

  ## Forward the default IPython notebook port on the guest
  ## to the host
  config.vm.network :forwarded_port, guest: 8888, host: 8888

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
