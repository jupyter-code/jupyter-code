#!/bin/bash


install_jupyter (){
    rm -rf ~/.local/share/code-server/CachedExtensionsVSIXs/
    rm -rf ~/.local/share/code-server/extensions/ms-python.python*/
    rm -rf ~/.local/share/code-server/extensions/ms-toolsai.jupyter*/
    curl -sfLO https://open-vsx.org/api/ms-toolsai/jupyter/2021.11.1001552333/file/ms-toolsai.jupyter-2021.11.1001552333.vsix
    curl -sfLO https://open-vsx.org/api/ms-python/python/2021.12.1559732655/file/ms-python.python-2021.12.1559732655.vsix
    code-server --install-extension ./ms-toolsai.jupyter-2021.11.1001552333.vsix
    code-server --install-extension ./ms-python.python-2021.12.1559732655.vsix
    rm ms-toolsai.jupyter-2021.11.1001552333.vsix
    rm ms-python.python-2021.12.1559732655.vsix
    sed -i 's/"activationEvents": \[/"enabledApiProposals": [\n\t\t"notebookConcatTextDocument",\n\t\t"notebookControllerKind",\n\t\t"notebookDebugOptions",\n\t\t"notebookDeprecated",\n\t\t"notebookEditor",\n\t\t"notebookEditorDecorationType",\n\t\t"notebookEditorEdit",\n\t\t"notebookMessaging",\n\t\t"notebookMime",\n\t\t"notebookCellExecutionState",\n\t\t"portsAttributes",\n\t\t"textDocumentNotebook",\n\t\t"quickPickSortByLabel"\n\t],\n\t"activationEvents": [/g' ~/.local/share/code-server/extensions/ms-toolsai.jupyter-2021.11.1001552333/package.json
}   

CURRENT_RELEASE="2"
CODE_SETTINGS=~/.local/share/code-server/User/settings.json
INSTALLED_RELEASE="0"
if [ -f  ~/.local/fingerprint ] ; then
    INSTALLED_RELEASE=$(cat ~/.local/fingerprint)
fi

if [ $INSTALLED_RELEASE -lt 1 ]; then
    install_jupyter
    SETTINGS=".\"files.exclude\".\"**/.*/\" = true | .\"telemetry.enableTelemetry\" = false"
    if [ -e $CODE_SETTINGS ] 
    then
        cat $CODE_SETTINGS | jq "$SETTINGS" > $CODE_SETTINGS.tmp
        mv $CODE_SETTINGS.tmp $CODE_SETTINGS
    else
        jq -n "$SETTINGS" > $CODE_SETTINGS
    fi
fi

if [ $INSTALLED_RELEASE -lt 2 ]; then
    curl -sfLO https://github.com/hm-riscv/vscode-riscv-venus/releases/download/v1.6.0/hm.riscv-venus-1.6.0.vsix
    code-server --install-extension ./hm.riscv-venus-1.6.0.vsix
    code-server --install-extension /opt/extensions/zhwu95.riscv-0.0.8.vsix
    rm hm.riscv-venus-1.6.0.vsix
fi

# Check that the installed release is less than 2 and not 0
if [ $INSTALLED_RELEASE -lt 3 ] && [ $INSTALLED_RELEASE -ne 0 ]; then
    install_jupyter
fi

echo "$CURRENT_RELEASE" > ~/.local/fingerprint