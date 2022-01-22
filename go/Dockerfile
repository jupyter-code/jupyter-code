ARG TAG=latest

FROM ghcr.io/jupyter-code/jupyter-code:$TAG

USER root

RUN sudo apt update && sudo apt install curl build-essential gcc make -y && \
    cd /tmp && \
    # install go 
    curl -O -L https://go.dev/dl/go1.17.6.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.6.linux-amd64.tar.gz

COPY scripts/start.sh /opt/scripts/start.sh

RUN chmod 755 /opt/scripts/*.sh && chmod +x /opt/scripts/*.sh

USER ${NB_USER}

ENV PATH $PATH:/usr/local/go/bin