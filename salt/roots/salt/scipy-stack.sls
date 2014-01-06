{% set username = pillar.get('username', 'vagrant') %}
{% set userhome = pillar.get('userhome', '/home/' + username) %}

scipy-stack-packages:
    pkg:
        - installed
        - names:
            # Salt optional stuff
            - git
            - vim
            - python-git

            # Optimized BLAS / LAPACK
            - libatlas3-base
            - libatlas-dev

            # Python2 stack
#            - python-numpy
#            - python-scipy
#            - python-matplotlib
#            - python-coverage
#            - python-nose
#            - ipython

            # Python3 stack
            - python3.3
#            - python3-numpy
#            - python3-scipy
#            - python3-matplotlib
#            - python3-pip
#            - ipython3


check-python3-pip:
    cmd.run:
        - name: wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python3.3 && easy_install-3.3 pip && pip install virtualenv
        - unless: command -v pip-3.3 >/dev/null 2>&1


python3-pip-packages:
    pip.installed:
        - names:
            - virtualenv
        - python: python3.3
        - require:
            - cmd: check-python3-pip

{{ userhome }}/venvs:
    file.directory:
        - makedirs: True
        - user: {{ username }}


{{ userhome }}/venvs/venv2:
    virtualenv.managed:
        - python: python
        - system_site_packages: True
        - ignore_installed: True
        - distribute: True
        - runas: {{ username }}
        - require:
            - file: {{ userhome }}/venvs
            - pkg: python-virtualenv


{{ userhome }}/venvs/venv3:
    virtualenv.managed:
        - python: python3
        - system_site_packages: True
        - ignore_installed: True
        - distribute: True
        - runas: {{ username }}
        - require:
            - pkg: python3
            - file: {{ userhome }}/venvs
            - pip: python3-pip-packages

venv3-packages:
    pip.installed:
        - names:
            - coverage
            - nose
        - bin_env: {{ userhome }}/venvs/venv3
        - require:
            - virtualenv: {{ userhome }}/venvs/venv3

ldconfig:
    cmd.run:
        - require:
            - pip: venv3-packages
