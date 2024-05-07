# Overview

This repository bootstraps a reproducible Jupyter kernel that includes a persistent Python environment with an extensive set of geospatial packages. It builds from another repo: https://github.com/UBC-Geography/jupyter-makefile.

Warning: While this repo can be extraordinarily convenient for setting up a new geospatial Python environment, it comes with some significant drawbacks. Because the environment includes such an extensive set of geospatial packages and their dependencies, it can require a few minutes for the environment to be fully installed on initial setup. Additionally, the environment itself requires approximately 2.4 GB. Some JupyterHub deployments, like [UBC Open Jupyter](https://open.jupyter.ubc.ca), only provide around 10 GB of storage space per user, meaning this environment will take about 25% of your total storage space, while others, like [UBC Syzygy](https://ubc.syzygy.ca), only provide 1 GB of storage, thus making it impossible to install this environment on that deployment.

To avoid some of the drawbacks noted above, identify the key packages needed for instruction or research. Create a new conda environment using only those packages and rely on pip as much as possible to avoid consuming too much memory. Then export the environment as an environment.yml file and pair it with the included Makefile to ensure your environment can be easily reproduced on other Jupyter servers.

# Installation

Start a new terminal session in your JupyterHub environment and clone this repository.

```bash
git clone https://github.com/ubc-geography/jupyter-py-geog-env
```

Run the following command to bootstrap the Python environment and install it as a new kernel.

```bash
make -C ~/jupyter-py-geog-env create_kernel
```

Once the kernel has been installed, you may need to wait another minute or two for the kernel to appear on the Jupyter launcher.

### Installing New Packages

You can add even more packages to the bootstrap environment by using the following commands.

```bash
# Install packages from PyPI
mamba run -p ~/jupyter-py-geog-env/env python -m pip install <package_name>
# Or install packages from conda-forge
mamba install -p ~/jupyter-py-geog-env/env <package_name>
# Recommended: Update the mamba/conda environment file
mamba env export -p ~/jupyter-py-geog-env/env > environment.yml
```

### To Remove the Environment and Kernel

```bash
make -C ~/jupyter-py-geog-env remove_kernel
```

## Template for Instructional Use

As a template repository, this repo can be used to quickly setup new repositories, which can be customized around various geospatial computing lessons while ensuring a consistent, reproducible environment is accessible from a JupyterHub deployment or other mamba-managed, Jupyter environment. To get started, select 'Use this template' and create a new repository in your GitHub account. Then add any data, scripts, and/or notebooks needed for your lesson before modifying the README.md file. Also consider modifying the PROJECT_NAME variable in the included Makefile to match the name of your lesson.

### Sharing Access

Once your lesson repository is ready to share, you can either 

- [make your repository public](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility#making-a-repository-public)

OR

- [create a fine-grained personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token)

If you select the latter, ensure that you restrict the token's permissions to only have read access to the content of your selected repository. Then share your GitHub username along with the generate token to enable your students to clone your private repository.

After cloning your repository, your students can then create the environment and install the kernel by opening a terminal in the clone repository and running

```bash
make create_kernel
```
