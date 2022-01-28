# JupyterLab meets Code-Server

This repo provides some ready to use Docker Images combining JupyterLab Images, Code Server and some popular programming languages like Go, Haskell or Rust.

## Base Image

* Based on the [default scipy-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-scipy-notebook) Docker image
* Integrated [code-server](https://github.com/coder/code-server) 
  * Preinstalled code extensions
    * GitLens
    * Jupyter
* Some additional ubuntu packages (`texlive-fonts-extra`, `latexmk`, `texlive-lang-german`, `texlive-science direnv`)
* Preinstalled JupyterLab extensions ([jupyterlab-git](https://github.com/jupyterlab/jupyterlab-git), [nbgitpuller](https://github.com/jupyterhub/nbgitpuller))

## Rust

* Preinstalled rustup in `/opt/`
* Preinstalled code extensions
  * Rust
  * Better Toml
* Preinstalled rust components
  * `rls`
  * `rust-analysis`
  * `rust-src`

## Go

* Go 1.17.6

## Haskell

* GHC 8.10.7
* Cabal 3.6.2.0
* Stack 2.7.3
* Preinstalled code extensions
  * Haskell
