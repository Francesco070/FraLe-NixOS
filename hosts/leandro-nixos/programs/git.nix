{ inputs, lib, config, pkgs, user, gitName, ... }: {
  programs.git = {
   enable = true;
   userName  = "${gitName}";
   userEmail = "";
   extraConfig = {
     pull = {
       rebase = true;
     };
   };
 };
}