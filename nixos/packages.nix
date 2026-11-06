{ pkgs, ... }:

# System-wide packages: only what root/the system needs.
# Everyday apps live in home-manager/packages.nix.
{
  environment.systemPackages = with pkgs; [
    git # root needs it for flake rebuilds
    wget
    pciutils
    gparted
    exfat
    exfatprogs
  ];

  # Login shell must be enabled system-wide.
  programs.fish.enable = true;
}
