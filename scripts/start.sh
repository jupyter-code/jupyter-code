#!/bin/bash
if [ ! -f  ~/.local/share/code-server/extensions/fingerprint ] || [ ! $(cat ~/.local/share/code-server/extensions/fingerprint) -eq "1635937972" ]; then
    rm -rf ~/.local/share/code-server/CachedExtensionsVSIXs/
    rm -rf ~/.local/share/code-server/extensions/ms-python.python-2021.10.1365161279/
    rm -rf ~/.local/share/code-server/extensions/ms-toolsai.jupyter-2021.8.12/
    curl -sfLO https://open-vsx.org/api/ms-toolsai/jupyter/2021.8.12/file/ms-toolsai.jupyter-2021.8.12.vsix
    curl -sfLO https://open-vsx.org/api/ms-python/python/2021.9.1218897484/file/ms-python.python-2021.9.1218897484.vsix 
    code-server --install-extension ./ms-toolsai.jupyter-2021.8.12.vsix
    code-server --install-extension ./ms-python.python-2021.9.1218897484.vsix
    rm ms-toolsai.jupyter-2021.8.12.vsix 
    rm ms-python.python-2021.9.1218897484.vsix
    echo "1635937972" > ~/.local/share/code-server/extensions/fingerprint
fi