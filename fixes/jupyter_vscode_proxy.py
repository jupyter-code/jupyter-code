import os
import shutil


def setup_vscode():
    def _get_vscode_cmd(port):
        executable = "code-server"
        if not shutil.which(executable):
            raise FileNotFoundError("Can not find code-server in PATH")

        cmd = [
            executable,
            "--auth",
            "none",
            "--disable-telemetry",
            "--port=" + str(port),
        ]
        return cmd

    return {
        "command": _get_vscode_cmd,
        "timeout": 20,
        "new_browser_tab": True,
        "launcher_entry": {
            "title": "VS Code",
            "path_info": "vscode/?folder=" + os.path.abspath(os.getcwd()),
            "icon_path": os.path.join(os.path.dirname(os.path.abspath(__file__)), "icons", "vscode.svg"),
        },
    }
