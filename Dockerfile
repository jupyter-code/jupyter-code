FROM jupyter/scipy-notebook
USER root
ARG RELEASE_TAG=openvscode-server-v1.60.2
RUN cd /tmp && \ 
    wget https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-v1.60.2/openvscode-server-v1.60.2-linux-x64.tar.gz && \
    tar -xzf ${RELEASE_TAG}-linux-x64.tar.gz  && \
    rm -f ${RELEASE_TAG}-linux-x64.tar.gz && \
    mv ${RELEASE_TAG}-linux-x64 /opt/code-server && \
    ln -s /opt/code-server/server.sh /usr/bin/code-server

USER ${NB_USER}

RUN jupyter labextension install @jupyterlab/git @jupyterlab/server-proxy && \
    pip install --no-cache-dir --upgrade jupyterlab-git jupyter-server-proxy nbgitpuller && \
    jupyter server extension enable --py jupyterlab_git jupyter_server_proxy && \
    pip install --no-cache-dir jupyter-vscode-proxy==0.1
