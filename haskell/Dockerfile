ARG TAG=latest

FROM ghcr.io/jupyter-code/jupyter-code:$TAG

USER root

RUN sudo apt update && sudo apt install -y build-essential curl libffi7 libgmp10 libncurses-dev libncurses5 libtinfo5 g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase jq git make texlive-fonts-extra direnv && \
    rm -rf /var/lib/apt/lists/* && \
    export CODE_BUILTIN_EXTENSIONS_DIR=/usr/lib/code-server/vendor/modules/code-oss-dev/extensions && \
    code-server --extensions-dir ${CODE_BUILTIN_EXTENSIONS_DIR} --install-extension haskell.haskell && \
    rm -rf /home/jovyan/.cache/ && \
    rm -rf /home/jovyan/.local/share/code-server/CachedExtensionVSIXs


# Taken from the official haskell docker container

ARG CABAL_INSTALL=3.6.2.0
ARG CABAL_INSTALL_RELEASE_KEY=A970DF3AC3B9709706D74544B3D9F94B8DCAE210
# get from https://downloads.haskell.org/~cabal/cabal-install-$CABAL_INSTALL/SHA256SUMS
ARG CABAL_INSTALL_RELEASE_SHA256=4759B56E9257E02F29FA374A6B25D6CB2F9D80C7E3A55D4F678A8E570925641C

RUN cd /tmp && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys ${CABAL_INSTALL_RELEASE_KEY} && \
    curl -fSLO https://downloads.haskell.org/~cabal/cabal-install-$CABAL_INSTALL/SHA256SUMS && \
    curl -fSLO https://downloads.haskell.org/~cabal/cabal-install-$CABAL_INSTALL/SHA256SUMS.sig && \
    gpg --batch --trusted-key B3D9F94B8DCAE210 --verify SHA256SUMS.sig SHA256SUMS && \
    curl -fSL https://downloads.haskell.org/~cabal/cabal-install-$CABAL_INSTALL/cabal-install-$CABAL_INSTALL-x86_64-linux-deb10.tar.xz -o cabal-install.tar.gz && \
    echo "$CABAL_INSTALL_RELEASE_SHA256 cabal-install.tar.gz" | sha256sum --strict --check && \
    tar -xf cabal-install.tar.gz -C /usr/local/bin && \
    rm -rf "$GNUPGHOME" /var/lib/apt/lists/* /tmp/*

ARG GHC=8.10.7
ARG GHC_RELEASE_KEY=88B57FCF7DB53B4DB3BFA4B1588764FBE22D19C4
# get from https://downloads.haskell.org/~ghc/$GHC/SHA256SUMS
ARG GHC_RELEASE_SHA256=A13719BCA87A0D3AC0C7D4157A4E60887009A7F1A8DBE95C4759EC413E086D30

RUN cd /tmp && \
  export GNUPGHOME="$(mktemp -d)" && \
  curl -sSL https://downloads.haskell.org/~ghc/$GHC/ghc-$GHC-x86_64-deb10-linux.tar.xz -o ghc.tar.xz && \
  curl -sSL https://downloads.haskell.org/~ghc/$GHC/ghc-$GHC-x86_64-deb10-linux.tar.xz.sig -o ghc.tar.xz.sig && \
  gpg --batch --keyserver keyserver.ubuntu.com --receive-keys ${GHC_RELEASE_KEY} && \
  gpg --batch --trusted-key 588764FBE22D19C4 --verify ghc.tar.xz.sig ghc.tar.xz && \
  echo "$GHC_RELEASE_SHA256 ghc.tar.xz" | sha256sum --strict --check && \
  tar xf ghc.tar.xz && \
  cd ghc-$GHC && \
  ./configure --prefix /opt/ghc/$GHC && \
  make install && \
  find /opt/ghc/$GHC/ \( -name "*_p.a" -o -name "*.p_hi" \) -type f -delete && \
  rm -rf /opt/ghc/$GHC/share/ && \
  rm -rf "$GNUPGHOME" /tmp/*

ARG STACK=2.7.3
ARG STACK_RELEASE_KEY=C5705533DA4F78D8664B5DC0575159689BEFB442
# get from https://github.com/commercialhaskell/stack/releases/download/v${STACK}/stack-${STACK}-linux-x86_64.tar.gz.sha256
ARG STACK_RELEASE_SHA256=A6C090555FA1C64AA61C29AA4449765A51D79E870CF759CDE192937CD614E72B

RUN cd /tmp && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys ${STACK_RELEASE_KEY} && \
    curl -fSL https://github.com/commercialhaskell/stack/releases/download/v${STACK}/stack-${STACK}-linux-x86_64.tar.gz -o stack.tar.gz && \
    curl -fSL https://github.com/commercialhaskell/stack/releases/download/v${STACK}/stack-${STACK}-linux-x86_64.tar.gz.asc -o stack.tar.gz.asc && \
    gpg --batch --trusted-key 575159689BEFB442 --verify stack.tar.gz.asc stack.tar.gz && \
    echo "$STACK_RELEASE_SHA256 stack.tar.gz" | sha256sum --strict --check && \
    tar -xf stack.tar.gz -C /usr/local/bin --strip-components=1 stack-$STACK-linux-x86_64/stack && \
    rm -rf "$GNUPGHOME" /var/lib/apt/lists/* /tmp/*
    
COPY scripts/start.sh /opt/scripts/start.sh

RUN chmod 755 /opt/scripts/*.sh && chmod +x /opt/scripts/*.sh

USER ${NB_USER}

ENV PATH /opt/ghc/${GHC}/bin:$PATH