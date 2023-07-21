{lib, ... }:
with lib;
let
	sysconfig = (import <nixpkgs/nixos> {}).config;
  cfg = sysconfig.services.xserver.desktopManager.xfce;
in {
  config = mkIf cfg.enable {
    xfconf.enable = true;
    xfconf.settings = {
      xfce4-keyboard-shortcuts = {
        "commands/custom/Super_L" = "xfce4-appfinder -c";
        "xfwm4/custom/<Primary><Super>Right" = "move_window_next_workspace_key";
        "xfwm4/custom/<Primary><Super>Left" = "move_window_prev_workspace_key";
      };
    };
  };
}
