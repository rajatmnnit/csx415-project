# Project: photographer_classifier

This file contains development, building and packaging instructions for Data Scientists / Developers touching this code in future.


## Development Instructions:

These instructions are to be followed on shell:
1.   Install git client if not already installed.
2.   Clone code locally from git repository https://github.com/rajatmnnit/csx415-project using the following command.
        ```
        git clone https://github.com/rajatmnnit/csx415-project.git
        ```

From now on, follow these instructions in Studio
1.   Install ProjectTemplate if not already installed using the following.
        ```
        getwd()   # Make sure your working dir is set to the directory where the code is cloned from git.
        install.packages('ProjectTemplate')
        library(ProjectTemplate)
        ```
2.   Run this command to create new project, only if the project directory is not already created: `create.project('photographer_classifier')`.
3.   Load project using the following.
        ```
        setwd('photographer_classifier')
        load.project()
        ```
4.    Install packrat, if not already installed using `install.packages('packrat')`.
5.    If running for the first time, run the following commands.
        ```
        packrat::set_opts(local.repos = './pkgs')
        packrat::install_local('PhotographerModels')
        packrat::install_local('PhotographerScoring')
        packrat::init('.')
        ```
6.    Turn packrat on using `packrat::on()`. You should see the libPath updated to project packrat lib directory.


## Developing Packages:

1.    Create a pkgs/ directory under project root, if not already present.
2.    Change to pkgs directory using `setwd('pkgs')`.
3.    Install devtools, testthat and roxygen2, if not already installed, using `install.packages(c('devtools', 'testthat', 'roxygen2'))`.
4.    Create package structure using devtools::create. For example, `devtools::create('PhotographerModels')`.
5.    Update DESCRIPTION file, write R code and write corresponding documentation and test cases.
6.    Generate package documentation by running this command from pkgs directory: `roxygen2::roxygenize('PhotographerModels')`.
7.    Change to package root by running `setwd('PhotographerModels')`.
8.    Build, test and install using the following commands.
        ```
        devtools::build()
        devtools::test()
        devtools::install()
        ```
9.    Make sure packrat snapshots are updated after new packages are installed.
        ```
        setwd('../..')
        packrat::install_local('PhotographerModels')
        packrat::snapshot()
        ```


## Packaging Instructions:

1.    Check that the working directory is the project root.
2.    Delete the old deployable bundle from deploy directory, if present, to avoid re-bundling it inside the new one.
3.    Check the status from packrat using `packrat::status()`.
4.    If required, update the packrat snapshot using `packrat::snapshot()`.
5.    Clear the data directory and cache to make sure no data is accidentally copied while packaging.
6.    Run the following command to create deployable bundle.
        ```
        packrat::bundle(include.src=TRUE, include.lib=FALSE, include.bundles=FALSE, overwrite=TRUE)
        ```
7.    Copy the bundle into deploy directory. Commit and push to git.
