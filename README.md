# Vagrant / Salt to work with Python 2 and 3 ScipPy stack

To use install:

- virtualbox
- vagrant

Then enable `salty-vagrant` with:

    [host]$ vagrant plugin install vagrant-salt

Then you can start the VM with:

    [host]$ vagrant up

The first start takes a couple of minutes to download the VM image, boot it,
and install most of the Scipy stats package with Salt. Subsequent calls to
`vagrant up` will be much faster.

Once started you can ssh into the VM with:

    [host]$ vagrant ssh

SSH agent forwarding is enabled by default to be able to use git from inside
the VM if needed.

Once there you can activate one of the 2 venvs:

    [guest]$ . venvs/py3/bin/activate

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

If you edit the salt configuration you can reapply.

    [guest]$ sudo salt-call state.highstate

Alternatively you can reboot the whole VM with:

    [host]$ vagrant reload
