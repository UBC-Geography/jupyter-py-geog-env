.PHONY: create_env remove_env create_kernel remove_kernel jupyter clean

#################################################################################
# GLOBALS                                                                       #
#################################################################################

## Change this variable
PROJECT_NAME=geog_env

## Update these variables if needed
CONDA_FILE=./environment.yml
PIP_FILE=./requirements.txt

## Avoid changing these variables
PROJECT_SLUG=$(notdir $(shell pwd))
PROJECT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
ENV=$(PROJECT_DIR)/env

## Set a fallback to conda if mamba is not installed
MAMBA=mamba
ifeq (,$(shell which $(MAMBA)))
MAMBA=conda
# Check that conda is in fact installed
ifeq (,$(shell which $(MAMBA)))
	$(error Neither mamba nor conda are found. Please install mamba before \
		using this Makefile)
else
	@echo mamba is not installed, falling back to conda
endif
endif

#################################################################################
# COMMANDS                                                                      #
#################################################################################

## Create the project's conda environment and install packages from files
create_env:
# If the env does not exist, create it using a prefix
ifeq (,$(shell $(MAMBA) info --envs | grep $(ENV)))
	$(MAMBA) create -p $(ENV)
# If a conda env file is included, update the env using it
ifneq (,$(wildcard $(CONDA_FILE)))
	$(MAMBA) env update -p $(ENV) --file $(CONDA_FILE)
# If a conda env file is not included, install a stable Python release
else
	$(MAMBA) install -p $(ENV) -c conda-forge -y python=3.11
endif
# If a pip requirements file is included, install packages listed from it
ifneq (,$(wildcard $(PIP_FILE)))
	$(MAMBA) run -p $(ENV) python -m pip install -r $(PIP_FILE)
endif
else
	@echo Environment already exists
endif

## Remove the project's conda environment
remove_env:
	$(MAMBA) env remove -p $(ENV)
	$(MAMBA) clean -afy

## Create a new Jupyter kernel using the project environment
create_kernel: create_env
# If ipykernel was not installed already, install it
ifeq (,$(shell $(MAMBA) list -p $(ENV) | grep ipykernel))
	$(MAMBA) run -p $(ENV) python -m pip install ipykernel
endif
ifeq (,$(shell jupyter kernelspec list | grep $(PROJECT_SLUG)$))
	$(MAMBA) run -p $(ENV) python -m ipykernel install --user --name \
		"$(PROJECT_SLUG)" --display-name "Python ($(PROJECT_NAME))"
else
	@echo Kernel is already installed
endif

## Remove the kernel from Jupyter
remove_kernel: remove_env
	jupyter kernelspec remove $(PROJECT_SLUG) -f

## Run the kernel in a local Jupyter environment
jupyter: create_kernel
	$(MAMBA) create -n jupyter_$(PROJECT_SLUG) -c conda-forge -y jupyter
	$(MAMBA) run -n jupyter_$(PROJECT_SLUG) --no-capture-output jupyter lab -y

## Modify the following as needed to run clean up tasks
clean: remove_kernel