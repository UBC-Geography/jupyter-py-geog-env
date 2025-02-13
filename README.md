# Overview

This repository bootstraps a reproducible Jupyter kernel that includes a
persistent Python environment with a core set of geospatial packages.

Pre-Installed Packages:

- Python 3.12.8
- GDAL 3.10.0
- PROJ 9.5.1
- GEOS 3.13.0
- numpy 2.2.1
- geopandas 1.0.1
- matplotlib 3.10.0
- ipyleaflet 0.19.2
- pandas 2.2.3
- pyproj 3.7.0
- rasterio 1.4.3
- rioxarray 0.18.1
- scipy 1.14.1
- shapely 2.0.6
- topojson 1.9
- xarray 2024.11.0

While this repo can be extraordinarily convenient for setting up a new
geospatial Python environment, it comes with some significant drawbacks. Because
the environment includes such an extensive set of dependencies, it can take
anywhere from 2 (local machine) to 11 minutes (UBC Open Jupyter) to install
depending hardware and networking. Additionally, the environment itself requires
approximately 1.1 GB. Some JupyterHub deployments, like
[UBC Open Jupyter](https://open.jupyter.ubc.ca), only provide around 10 GB of
storage space per user, meaning this environment will take about 11% of your
total storage space.

To avoid some of the drawbacks noted above, identify the key packages needed for
instruction or research. Create a new conda environment using only those
packages and rely on pip as much as possible to avoid exceeding limits on memory
usage. Then export the environment as an `environment.yml` file and pair it with
the included Makefile to ensure your environment can be easily reproduced on
other Jupyter servers.

# Installation

Start a new terminal session in your JupyterHub environment and clone this
repository.

```bash
git clone https://github.com/ubc-geography/jupyter-py-geog-env
```

Run the following command to bootstrap the Python environment and install it as
a new kernel.

```bash
make -C ~/jupyter-py-geog-env create_kernel
```

Once the kernel has been installed, you may need to wait another minute or two
for the kernel to appear on the Jupyter Lab launcher.

### Installing New Packages

You can add even more packages to the bootstrap environment by using the
following commands.

```bash
# Install packages from PyPI
mamba run -p ~/jupyter-py-geog-env/env python -m pip install <package_name>
# Or install packages from conda-forge
mamba install -p ~/jupyter-py-geog-env/env <package_name>
# Recommended: Update the mamba/conda environment file after installing new packages to ensure the environment is reproducible
mamba env export -p ~/jupyter-py-geog-env/env --no-build > environment.yml
```

### To Remove the Environment and Kernel

```bash
make -C ~/jupyter-py-geog-env remove_kernel
```

## Template for Instructional Use

As a template repository, this repo can be used to quickly setup new
repositories, which can be customized around various geospatial computing
lessons. This can ensure a consistent, reproducible environment is accessible
from a JupyterHub deployment or other conda-based, Jupyter environment. To get
started, select 'Use this template' and create a new repository in your GitHub
account. Then add any data, scripts, and/or notebooks needed for your lesson
before modifying the README.md file. Also consider modifying the PROJECT_NAME
variable in the included Makefile to match the name of your lesson.

### Sharing Access

Once your lesson repository is ready to share, you can either

- [make your repository public](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility#making-a-repository-public)

OR

- [create a fine-grained personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token)

If you select the latter option, ensure that you restrict the token's
permissions to only have read access to the content of your selected repository.
Then share your GitHub username along with the generated token to enable your
students to clone your private repository.

After cloning your repository, your students can then create the environment and
install the kernel by opening a terminal in the cloned repository and running

```bash
make create_kernel
```
