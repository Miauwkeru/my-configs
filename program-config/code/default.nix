{ pkgs, config, ... }:
let 
  podman-wrapper = pkgs.writeScriptBin "podman-wrapper" ''
  #!/bin/sh
  BUILDAH_FORMAT=docker \
  PODMAN_USERNS=keep-id \
  podman "$@"
  '';
in 
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      jnoortheen.nix-ide
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      vscodevim.vim
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
    } // {
      "dev.containers.dockerPath" = "${podman-wrapper}/bin/podman-wrapper";
      "editor.rulers" = [80 120];
    };
  };
}
