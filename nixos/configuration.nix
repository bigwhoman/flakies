# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix 
    ];

  
  services.lvm = {
    enable = false;
  };

  swapDevices = [ {
        # replace this with your swap partition !!!!
	#device = swapDevice;
	device = "/swapfile";
	size = 100000;
  } ];  


   boot.supportedFilesystems = ["exfat"];
   services.udisks2.enable = true;



   boot.initrd.systemd.enable = true;
  # Add hibernation
  #boot.resumeDevice = swapDevice;
#   resumeDevice = "/dev/disk/by-uuid/98ffc29b-ec13-45ee-b619-a817d2d4e49c";
#   boot.kernelParams = [
#	"resume_offset=57593856"
#   ];
  boot.kernelParams = [ "module_blacklist=i915" "acpi_backlight=video" "video.only_lcd=0" "i2c-dev"];

  services.logind = {
	lidSwitch = "hibernate";
	extraConfig = ''
		HandlePowerKey=hibernate
		IdleAction=hibernate
		IdleActionSec=30min
	'';
  }; 
 
  nix.package = pkgs.nixVersions.stable;
  nix.extraOptions = ''
	experimental-features = nix-command flakes
  '';
	



  fonts.packages = [
           pkgs.nerd-fonts._0xproto
           pkgs.nerd-fonts.droid-sans-mono
	   pkgs.font-awesome
	   pkgs.nerd-fonts.jetbrains-mono
         ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  boot.kernelModules = [ "nvidia" ];
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  programs.nix-ld.enable = true;
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
# In /etc/nixos/configuration.nix
  services.udev.extraRules = ''
# Give i2c group members access to i2c devices
	  KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
	  '';

# Create i2c group and add your user to it
  users.groups.i2c = {};
  virtualisation.docker.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
	  enable = true;
	  qemu = {
	    package = pkgs.qemu_kvm;
	    runAsRoot = true;
	    swtpm.enable = true;
	    ovmf = {
	      enable = true;
	      packages = [(pkgs.OVMF.override {
		secureBoot = true;
		tpmSupport = true;
	      }).fd];
	    };
	  };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
  	powerManagement.enable = true;
	modesetting.enable = true;
	open = true;
	nvidiaSettings = true;
	package = config.boot.kernelPackages.nvidiaPackages.stable;

  };
  hardware.i2c.enable = true;
  
  # Enable the KDE Plasma Desktop Environment.
  #services.displayManager.sddm.enable = true;
  #services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

#  hardware.pulseaudio = {
#    enable = true;
#    package = pkgs.pulseaudioFull; # Full package includes more codecs and plugins
#    # Try explicitly loading the module for your headset
#    extraConfig = ''
#      load-module module-alsa-card
#    '';
#  };

  # Enable sound with pipewire.
  #hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bigwhoman = {
    isNormalUser = true;
    description = "hooman";
    shell = pkgs.fish;
    extraGroups = [ "vscode-server" "i2c" "networkmanager" "wheel" "docker" "libvirtd" "audio" "dialout"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICs9+7homZ6YB8UhpfvQ80yLr5zD8Z6KlEQ3RXRKETCW bigwhoman@arch" 
    ];
    packages = with pkgs; [
    #  kdePackages.kate
    #  thunderbird
    ];
  };

  users.extraGroups.docker.members = ["bigwhoman"];

  # Install firefox.
  programs.firefox.enable = true;
  programs.fish = {
	enable = true;
  };
  programs.steam = {
  	enable = true;
  	remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  	dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  	localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


 programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      #obs-pipewire-audio-capture
    ];
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neofetch
    pciutils
    btop
    fish
    tmux
    gparted
    brave   
    stow
    exfat
    exfatprogs
    libsForQt5.powerdevil
    vscode
    ddcutil
    git
    (python3.withPackages(ps: with ps; [


    pip
    numpy
    pandas
    scipy
    matplotlib
    ipykernel
    jupyter
    torch

     ]))
    telegram-desktop
  ];


 programs.git = {
    enable = true;
    config = {
	user = {
    		userName  = "bigwhoman";
        	userEmail = "hm.keshvari@gmail.com";
        };
    };
  };
  


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.openssh = {
  	enable = true;
	settings = {
		PasswordAuthentication = false;
		X11Forwarding = true;
		AllowUsers = [ "bigwhoman" ];
	};
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
