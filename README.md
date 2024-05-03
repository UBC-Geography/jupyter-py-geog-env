# Overview

This repository bootstraps a reproducible Jupyter kernel that includes a persistent Python environment with an extensive set of geospatial packages. It builds from another repo: https://github.com/UBC-Geography/jupyter-makefile.

Warning: While this repo can be extraordinarily convenient for setting up a new geospatial Python environment, it comes with some significant drawbacks. Because the environment includes such an extensive set of geospatial packages and their dependencies, it can require a few minutes for the environment to be fully installed on initial setup. Additionally, the environment itself requires approximately 2.4 GB. Some JupyterHub deployments, like [UBC Open Jupyter](https://open.jupyter.ubc.ca), only provide around 10 GB of storage space per user, meaning this environment will take about 25% of your total storage space, while others, like [UBC Syzygy](https://ubc.syzygy.ca), only provide 1 GB of storage, thus making it impossible to install this environment on that deployment.

To avoid some of the drawbacks noted above, identify the key packages needed for instruction or research. Create a new conda environment using only those packages and rely on pip as much as possible to avoid consuming too much memory. Then export the environment as an environment.yml file and pair it with the included Makefile to ensure your environment can be easily reproduced on other Jupyter servers.

## Installation

Start a new terminal session in your JupyterHub environment and clone this repository.

```bash
git clone https://github.com/ubc-geography/jupyter-py-geog-env
```

4. Run the following command to bootstrap the Python environment and install it as new kernel

```bash
make -C ~/jupyter-py-geog-env create_kernel
```

Once the kernel has been installed, you may need to wait another minute or two for the kernel to appear on the Jupyter launcher.

### Installing New Packages

You can added even more packages to the bootstrap environment by using the following commands.

```bash
# Install packages from PyPI
conda run -p ~/jupyter-py-geog-env/env python -m pip install <package_name>
# Or install packages from conda-forge
mamba install -p ~/jupyter-py-geog-env/env <package_name>
# Recommended: Update the mamba/conda environment file
mamba env export -p ~/jupyter-py-geog-env/env > environment.yml
```

### To Remove the Environment and Kernel

```bash
make remove_kernel
```