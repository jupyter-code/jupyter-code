FROM jupyter/scipy-notebook:2022-01-03
USER root

RUN curl -fsSL https://code-server.dev/install.sh | sh && \
    sudo apt update && sudo apt install -y curl jq git make texlive-fonts-extra direnv && \
    rm -rf /var/lib/apt/lists/* 

ADD requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt && \
    cp /opt/conda/lib/python3.9/site-packages/nbgitpuller/templates/status.html /opt/conda/lib/python3.9/site-packages/notebook/templates/status.html && \ 
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" 

COPY scripts /opt/scripts
COPY extensions /opt/extensions
RUN chmod 755 /opt/scripts/*.sh && chmod +x /opt/scripts/*.sh

USER ${NB_USER}
ADD fixes/jupyter_vscode_proxy.py /opt/conda/lib/python3.9/site-packages/jupyter_vscode_proxy/__init__.py
RUN jupyter labextension install @jupyterlab/git @jupyterlab/server-proxy && \
    jupyter server extension enable --py jupyterlab_git jupyter_server_proxy livefeedback
