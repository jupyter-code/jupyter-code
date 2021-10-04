FROM jupyter/scipy-notebook

RUN curl -fsSL https://code-server.dev/install.sh | sh && \
    jupyter labextension install @jupyterlab/git @jupyterlab/server-proxy && \
    pip install --no-cache-dir --upgrade jupyterlab-git jupyter-server-proxy nbgitpuller && \
    jupyter server extension enable --py jupyterlab_git jupyter_server_proxy && \
    pip install --no-cache-dir jupyter-vscode-proxy==0.1
