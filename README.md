# Vagrant setup to work with Python 2 / 3 & SciPy

Use Vagrant to automatically configure a Ubuntu VM from scratch and bootstrap
it with [SaltStack](http://docs.saltstack.com/) to install the SciPy stack with
a mix of Ubuntu packages and virtualenvs.

To get started install:

- [Virtualbox](https://www.virtualbox.org/) (Virtual Machine runner)
- [Vagrant](http://www.vagrantup.com/) (Command-line tool to control VMs)

Then enable `salty-vagrant` with:

    [host]$ vagrant plugin install vagrant-salt

It can be helpful to tell vagrant to automatically install the virtualbox
guest additions for the matching version to solve shared folder issues:

    [host]$ vagrant plugin install vagrant-vbguest

Then you can start the VM with:

    [host]$ vagrant up

The first start takes a couple of minutes to download the VM image, boot it,
and install most of the Scipy stats package with Salt. Subsequent calls to
`vagrant up` will be much faster.

Once started you can ssh into the VM with:

    [host]$ vagrant ssh

SSH agent forwarding is enabled by default to be able to use git from inside
the VM if needed.

Once there you can activate one of the 2 venvs, for instance for Python 3:

    [guest]$ . venvs/venv3/bin/activate

You can suspend / resume the VM with to temporarily free the memory on the host
with `vagrant suspend` / `vagrant resume`. Or shutfown and destroy the VM
completely to also free the disk with:

    [host]$ vagrant destroy


## Vagrant configuration

Edit the `Vagrantfile` to customize:

- VM image (Ubuntu 13.04 64 bits by default)
- VM RAM size
- shared folders
- port forwarding


## Salt configuration

The configuration is a bunch of text files in:

    salt/roots/salt/

In particular the Ubuntu packages and virtualenv configuration is in:

    salt/roots/salt/scipy-stack.sls

Read the [SaltStack documentation](http://docs.saltstack.com/) to get started
with custom state files.

If you edit the salt configuration you can ask salt to quickly take all your
changes into accout from inside the VM:

    [guest]$ sudo salt-call state.highstate

Alternatively you can reboot the whole VM with from outside of the VM:

    [host]$ vagrant reload
