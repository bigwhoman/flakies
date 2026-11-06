{ pkgs, ... }:

{
  nix.package = pkgs.nixVersions.stable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  services.lvm.enable = false;
  boot.supportedFilesystems = [ "exfat" ];
  services.udisks2.enable = true;

  networking.networkmanager.enable = true;

  users.users.bigwhoman = {
    isNormalUser = true;
    description = "hooman";
    shell = pkgs.fish;
    extraGroups = [ "vscode-server" "i2c" "networkmanager" "wheel" "docker" "libvirtd" "audio" "dialout" "plugdev" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICs9+7homZ6YB8UhpfvQ80yLr5zD8Z6KlEQ3RXRKETCW bigwhoman@arch"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      X11Forwarding = true;
      AllowUsers = [ "bigwhoman" ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.vscode-server.enable = true;

  # Lets prebuilt (non-Nix) binaries run.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    curl
    # add more as things complain
  ];
}
