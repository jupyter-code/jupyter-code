ARG TAG=latest
FROM ghcr.io/jupyter-code/jupyter-code:$TAG

USER root

RUN sudo apt update && sudo apt install curl build-essential gcc make pkg-config libssl-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    export CODE_BUILTIN_EXTENSIONS_DIR=/usr/lib/code-server/vendor/modules/code-oss-dev/extensions && \
    code-server --extensions-dir ${CODE_BUILTIN_EXTENSIONS_DIR} --install-extension rust-lang.rust && \
    code-server --extensions-dir ${CODE_BUILTIN_EXTENSIONS_DIR} --install-extension  bungcip.better-toml
RUN curl https://sh.rustup.rs -sSf | sudo env RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo sh -s -- --default-toolchain stable --profile default --no-modify-path -y

ENV PATH ${PATH}:/opt/rust/cargo/bin
RUN RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo rustup update && \
    RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo rustup component add rls rust-analysis rust-src

COPY scripts/start.sh /opt/scripts/start.sh

RUN chmod 755 /opt/scripts/*.sh && chmod +x /opt/scripts/*.sh

USER ${NB_USER}

ENV RUSTUP_HOME /opt/rust/rustup 
ENV PATH ${PATH}:/opt/rust/cargo/bin