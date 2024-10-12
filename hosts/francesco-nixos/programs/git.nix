{ inputs, lib, config, pkgs, user, gitName, ... }: {
  programs.git = {
   enable = true;
   userName  = "${gitName}";
   userEmail = "2007f.palazzo@gmail.com";
   extraConfig = {
     pull = {
       rebase = true;
     };
   };
 };
}