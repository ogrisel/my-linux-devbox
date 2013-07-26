scipy-stack-packages:
    pkg:
        - installed
        - names:
            # Salt optional stuff
            - git
            - vim
            - python-git

            # Python2 stack
            - python-numpy
            - python-scipy
            - python-matplotlib
            - python-pip
            - python-coverage
            - python-virtualenv
            - python-nose
            - ipython

            # Python3 stack
            - python3-numpy
            - python3-scipy
            - python3-matplotlib
            - python3-pip
            - ipython3

python3-pip-packages:
    pip.installed:
        - names:
            - virtualenv
        - python: python3


/home/vagrant/work:
    file.directory:
        - makedirs: True


/home/vagrant/work/venv2:
    virtualenv.managed:
        - python: python
        - system_site_packages: True
        - ignore_installed: True
        - distribute: True
        - runas: vagrant
        - require:
            - file: /home/vagrant/work
            - pkg: python-virtualenv


/home/vagrant/work/venv3:
    virtualenv.managed:
        - python: python3
        - system_site_packages: True
        - ignore_installed: True
        - distribute: True
        - runas: vagrant
        - require:
            - file: /home/vagrant/work
            - pip: python3-pip-packages

venv3-packages:
    pip.installed:
        - names:
            - coverage
            - nose
        - bin_env: /home/vagrant/work/venv3
