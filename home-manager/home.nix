{ ... }:

{
  imports = [
    ./packages.nix
    ./shell.nix
    ./neovim.nix
    ./ssh.nix
    ./git.nix
  ];

  home.username = "bigwhoman";
  home.homeDirectory = "/home/bigwhoman";
  home.stateVersion = "22.11";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;

  home.sessionVariables.EDITOR = "nvim";
}
