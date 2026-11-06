# Shared system config: works on any machine. Imported by hosts/<name>/default.nix.
{ ... }:

{
  imports = [
    ./base.nix
    ./desktop.nix
    ./virtualisation.nix
    ./packages.nix
  ];
}
