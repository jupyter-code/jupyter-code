FROM jupyter/scipy-notebook:2022-01-03
USER root

RUN --mount=type=secret,id=github_token \
    TOKEN=$(cat /run/secrets/github_token) && \
    wget --header "authorization: Bearer $TOKEN" --quiet https://api.github.com/repos/fritterhoff/code-server/actions/artifacts/137034267/zip -O /tmp/release-package.zip && \
    unzip /tmp/release-package.zip -d /tmp && \
    dpkg -i /tmp/code-server_*_amd64.deb && \
    rm -rf /tmp/* && \
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
