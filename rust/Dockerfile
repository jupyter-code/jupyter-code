ARG TAG=latest
FROM ghcr.io/jupyter-code/jupyter-code:$TAG

USER root

RUN sudo apt update && sudo apt install curl build-essential gcc make -y && \
    rm -rf /var/lib/apt/lists/* && \
    export CODE_BUILTIN_EXTENSIONS_DIR=/usr/lib/code-server/vendor/modules/code-oss-dev/extensions && \
    code-server --extensions-dir ${CODE_BUILTIN_EXTENSIONS_DIR} --install-extension haskell.haskell

COPY scripts /opt/scripts

RUN chmod 755 /opt/scripts/*.sh && chmod +x /opt/scripts/*.sh

USER ${NB_USER}

ENV PATH /opt/ghc/${GHC}/bin:$PATH