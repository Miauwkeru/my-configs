{ ... }:
{
  home.shellAliases = {
    update = "nix-channel --update && sudo nix-channel--update && sudo nixos-rebuild switch && home-manager switch";
    clean = "nix-collect-garbage -d";
  };
}
