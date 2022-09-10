FROM jupyter/scipy-notebook:2022-08-04
USER root

RUN sudo apt update && sudo apt install -y curl jq git make texlive-fonts-extra latexmk texlive-lang-german texlive-science direnv && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /home/jovyan/.cache/

RUN curl -fsSL https://code-server.dev/install.sh | sh && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /home/jovyan/.cache/

RUN export CODE_BUILTIN_EXTENSIONS_DIR=/usr/lib/code-server/lib/vscode/extensions && \
    mkdir -p ${CODE_BUILTIN_EXTENSIONS_DIR} && \
    code-server --extensions-dir ${CODE_BUILTIN_EXTENSIONS_DIR} --install-extension ms-python.python && \
    code-server --extensions-dir ${CODE_BUILTIN_EXTENSIONS_DIR} --install-extension ms-toolsai.jupyter && \
    code-server --extensions-dir ${CODE_BUILTIN_EXTENSIONS_DIR} --install-extension eamodio.gitlens && \    
    cd ${CODE_BUILTIN_EXTENSIONS_DIR}/ms-toolsai.jupyter-2022.8.1002460559 && mkdir -m 1777 tmp && mkdir -m 1777 temp  && \
    rm /usr/lib/code-server/lib/vscode/bin/remote-cli/code-server && \
    rm -rf /home/jovyan/.cache/ && \
    rm -rf /home/jovyan/.local/share/code-server/CachedExtensionVSIXs


ADD requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt && \
    cp /opt/conda/lib/python3.10/site-packages/nbgitpuller/templates/status.html /opt/conda/lib/python3.10/site-packages/notebook/templates/status.html && \ 
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    rm -rf /home/jovyan/.cache/ 

COPY scripts /opt/scripts
COPY extensions /opt/extensions
RUN chmod 755 /opt/scripts/*.sh && chmod +x /opt/scripts/*.sh

USER ${NB_USER}
ADD fixes/jupyter_vscode_proxy.py /opt/conda/lib/python3.10/site-packages/jupyter_vscode_proxy/__init__.py
RUN jupyter labextension install @jupyterlab/git @jupyterlab/server-proxy && \
    jupyter server extension enable --py jupyterlab_git jupyter_server_proxy livefeedback && \
    rm -rf /home/jovyan/.cache/ 
