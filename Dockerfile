FROM jupyter/scipy-notebook

RUN jupyter labextension install @jupyterlab/git @jupyterlab/server-proxy && \
    pip install --upgrade jupyterlab-git jupyter-server-proxy && \
    jupyter server extension enable --py jupyterlab_git jupyter_server_proxy
