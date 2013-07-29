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
            - python3
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


/home/vagrant/venvs:
    file.directory:
        - makedirs: True
        - user: vagrant


/home/vagrant/venvs/venv2:
    virtualenv.managed:
        - python: python
        - system_site_packages: True
        - ignore_installed: True
        - distribute: True
        - runas: vagrant
        - require:
            - file: /home/vagrant/venvs
            - pkg: python-virtualenv


/home/vagrant/venvs/venv3:
    virtualenv.managed:
        - python: python3
        - system_site_packages: True
        - ignore_installed: True
        - distribute: True
        - runas: vagrant
        - require:
            - pkg: python3
            - file: /home/vagrant/venvs
            - pip: python3-pip-packages

venv3-packages:
    pip.installed:
        - names:
            - coverage
            - nose
        - bin_env: /home/vagrant/venvs/venv3
        - require:
            - virtualenv: /home/vagrant/venvs/venv3

ldconfig:
    cmd.run:
        - require:
            - pip: venv3-packages
