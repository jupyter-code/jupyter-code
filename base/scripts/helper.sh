#!/bin/bash

CODE_SETTINGS=~/.local/share/code-server/User/settings.json

update_settings() {
    SETTINGS=".\"files.exclude\".\"**/.*/\" = true  | \"gitlens.plusFeatures.enabled\": false | \"gitlens.showWelcomeOnInstall\": false | \"gitlens.showWhatsNewAfterUpgrades\": false |\"gitlens.virtualRepositories.enabled\": false | .\"telemetry.enableTelemetry\" = false | .\"python.defaultInterpreterPath\" = \"/opt/conda/bin/python\""
    if [ -e $CODE_SETTINGS ] 
    then
        cat $CODE_SETTINGS | jq "$SETTINGS" > $CODE_SETTINGS.tmp
        mv $CODE_SETTINGS.tmp $CODE_SETTINGS
    else
        mkdir -p ~/.local/share/code-server/User
        jq -n "$SETTINGS" > $CODE_SETTINGS
    fi
}