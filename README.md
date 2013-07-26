# Vagrant / Salt to work with Python 2 and 3 ScipPy stack

To use install:

- virtualbox
- vagrant

Then enable `salty-vagrant` with:

    vagrant plugin install vagrant-salt

Then you can start the VM with:

    vagrant up

Get a shell connection with:

    vagrant ssh


## Salt configuration

The configuration is a bunch of text files in:

    salt/roots/salt/

In particular the Ubuntu packages and virtualenv configuration is in:

    salt/roots/salt/scipy-stack.sls
