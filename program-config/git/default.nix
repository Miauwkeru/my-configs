{ ... }:
{
   programs.git = {
     enable = true;
     lfs.enable = true;
     userName = "Miauwkeru";
     userEmail = "Miauwkeru@users.noreply.github.com";
     aliases = {
      co = "checkout";
      re = "rebase";
     };
     extraConfig.pull.rebase = true;
   };
   programs.ssh.matchBlocks.github = {
    host = "github.com";
    identityFile = ["~/.ssh/id_github"];
   };
}
