# Everything specific to THIS computer (disks, GPU, kernel quirks, power).
# For a new machine: copy this folder, replace hardware-configuration.nix
# with the new machine's generated one, and edit the rest.
{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../nixos
  ];

  networking.hostName = "nixos";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;

  swapDevices = [ {
    device = "/swapfile";
    size = 100000;
  } ];

  boot.kernelParams = [ "module_blacklist=i915" "acpi_backlight=video" "video.only_lcd=0" "i2c-dev" ];

  services.logind = {
    lidSwitch = "hibernate";
    settings.Login = {
      HandlePowerKey = "hibernate";
      IdleAction = "hibernate";
      IdleActionSec = "30min";
    };
  };

  # DDC/CI monitor control (ddcutil) over i2c.
  hardware.i2c.enable = true;
  users.groups.i2c = {};
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # Set at first install; never bump it when upgrading.
  system.stateVersion = "25.11";
}
