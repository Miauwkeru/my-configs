{ pkgs, config, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      eamodio.gitlens
    ] ++ (
      if (config.gtk.theme.name == "Dracula" )
      then [
        dracula-theme.theme-dracula
       ] else []
    );
    userSettings = builtins.fromJSON (
      builtins.readFile ./settings.json
    ) // {
      "workbench.preferredDarkColorTheme" = "${config.gtk.theme.name}";
      "workbench.colorTheme" = "${config.gtk.theme.name}";
    };
  };
}