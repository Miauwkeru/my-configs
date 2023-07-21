{ config, ... }:
let
  cfg = config.programs;
in
{
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    enableBashIntegration = cfg.bash.enable;
    enableFishIntegration = cfg.fish.enable;
    enableIonIntegration = cfg.ion.enable;
    enableNushellIntegration = cfg.nushell.enable;
    enableZshIntegration = cfg.zsh.enable;
  };
}
