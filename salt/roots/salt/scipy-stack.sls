deadsnakes-ppa:
  pkg.installed:
    - names:
        - python-software-properties
  pkgrepo.managed:
    - ppa: fkrull/deadsnakes


system-packages:
    pkg.installed:
        - names:
            # Salt optional stuff
            - git
            - vim
            - python-git

            # Optimized BLAS / LAPACK
            - libatlas3-base
            - libatlas-dev

            # Matplotlib system build dependencies
            - libagg-dev
            - libpng-dev
            - libjpeg-dev
            - libfreetype6-dev
            - libfontconfig1-dev

            # Python interpreters
            {% for pyversion in ['2.6','2.7','3.2', '3.3'] %}
            - python{{ pyversion }}
            - python{{ pyversion }}-dev
            {% endfor %}

            # Install all Python packages from source or wheels in virtualenvs
            # with pip
            - python-pip
        - require:
            - pkgrepo: deadsnakes-ppa


common-pip-packages:
  pip.installed:
    - names:
        - virtualenv
        - virtualenvwrapper
    - require:
      - pkg: python-pip


/home/vagrant/.bashrc:
  file.append:
    - text:
        - export WORKON_HOME="/home/vagrant/venvs"
        - source /usr/local/bin/virtualenvwrapper.sh
    - require:
        - pip: virtualenvwrapper


/home/vagrant/venvs:
    file.directory:
        - makedirs: True
        - user: vagrant


{% for pyversion in ['2.6','2.7','3.2', '3.3'] %}
/home/vagrant/venvs/{{ pyversion }}:
    virtualenv.managed:
        - python: python{{ pyversion }}
        - distribute: True
        - runas: vagrant
        - require:
            - pkg: python{{ pyversion }}
            - file: /home/vagrant/venvs
            - pip: virtualenv
    pip.installed:
        - names:
            - coverage
            - nose
            - ipython[all]
            - matplotlib
        - bin_env: /home/vagrant/venvs/{{ pyversion }}
        - user: vagrant
        - use_wheel: True
{% endfor %}

