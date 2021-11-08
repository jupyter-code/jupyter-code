FROM jupyter/scipy-notebook:2021-11-08
USER root

RUN sudo apt update && sudo apt install -y curl jq git && \
    rm -rf /var/lib/apt/lists/* && \
    curl -fsSL https://code-server.dev/install.sh | sh

ADD requirements.txt /tmp/requirements.txt
RUN  pip install --no-cache-dir -r /tmp/requirements.txt && fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

COPY scripts /opt/scripts
RUN chmod 755 /opt/scripts/*.sh && chmod +x /opt/scripts/*.sh

USER ${NB_USER}

RUN jupyter labextension install @jupyterlab/git @jupyterlab/server-proxy && \
    jupyter server extension enable --py jupyterlab_git jupyter_server_proxy

