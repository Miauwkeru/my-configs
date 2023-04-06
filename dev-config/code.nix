{ config, pkgs, ...}:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
    ];
  };
}
