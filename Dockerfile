FROM jupyter/scipy-notebook
USER root

RUN sudo apt update && sudo apt install -y curl && \
    rm -rf /var/lib/apt/lists/* && \
    curl -fsSL https://code-server.dev/install.sh | sh

RUN  pip install --no-cache-dir otter-grader roboworld

USER ${NB_USER}

RUN jupyter labextension install @jupyterlab/git @jupyterlab/server-proxy && \
    pip install --no-cache-dir --upgrade jupyterlab-git jupyter-server-proxy nbgitpuller && \
    jupyter server extension enable --py jupyterlab_git jupyter_server_proxy && \
    pip install --no-cache-dir jupyter-vscode-proxy==0.1 && \
    pip install --no-cache-dir https://github.com/fritterhoff/livefeedback/archive/refs/heads/main.zip

RUN SERVICE_URL="https://open-vsx.org/vscode/gallery" ITEM_URL="https://open-vsx.org/vscode/item" code-server --install-extension ms-python.python
RUN SERVICE_URL="https://open-vsx.org/vscode/gallery" ITEM_URL="https://open-vsx.org/vscode/item" code-server --install-extension ms-toolsai.jupyter