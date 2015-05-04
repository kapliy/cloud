BASE_PATH = /opt/anaconda/2.2.0
ENV_NAME  = pandas0.13
ENV_PATH  = $(BASE_PATH)/envs/$(ENV_NAME)
CONDA     = $(BASE_PATH)/bin/conda
PIP       = $(ENV_PATH)/bin/pip

.PHONY: pyenv conda pip pydist remove

all: pyenv

pyenv: conda pip pydist

conda: 
	$(CONDA) create --yes -n $(ENV_NAME) --file conda-requirements.txt

pip:
	$(PIP) install -r pip-requirements.txt --allow-external pp --allow-unverified pp

pydist:
	$(PIP) install -r pydist-requirements.txt --find-links http://pydist

remove:
	$(CONDA) remove --yes -n $(ENV_NAME) --all
