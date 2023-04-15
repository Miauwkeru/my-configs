{ pkgs, config, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      eamodio.gitlens
    ];
    userSettings = builtins.fromJSON (
      builtins.readFile ./settings.json
    ) // {
        "terminal.integrated.fontFamily" = "'FiraCode Nerd Font'";
        "editor.fontFamily" = "'FiraCode Nerd Font'";
        "editor.codeLensFontFamily" = "'FiraCode Nerd Font'";
    };
  };
}