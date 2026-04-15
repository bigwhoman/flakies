{ config, pkgs, inputs, lib, ...}:


{
  home.username = "bigwhoman";
  home.homeDirectory = "/home/bigwhoman";
  home.stateVersion = "22.11";
  nixpkgs = { 
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };

  };
  services.ssh-agent.enable = true;


  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    kitty
      wezterm
      claude-code
      rustup
      signal-desktop
      gemini-cli
      playerctl
      wofi
      spotify
      bat
      openssl
      curl.dev
      pkg-config
      waybar
      hyprpaper
      hyprshot
      hyprsunset
      wlogout
      fzf
      ripgrep
      jq
      tree
      vlc
      cmake
      wabt
      eza
      todoist
      dmidecode
      zathura
      texliveFull
      tldr
      gpustat		
      killall
      lm_sensors
      bluetui
      swaylock-effects
      discord
      brightnessctl
      cliphist
      wireplumber
      rofi
      arduino-ide
      hdparm
      usbutils
      arduino-cli
      xfce.thunar
      alsa-utils
      pavucontrol
      stdenv
      lazygit
      virtualbox
      p7zip
      unzip
      zip
      lshw

      gcc
      gnumake
      clang-tools
      lldb
      cpplint
      fzf
      isort
      black
      prettierd
      stylua
      zotero
      ranger
      gnome-pomodoro
      tdf
      microsoft-edge
      evince
      obsidian
      sshfs
      ];
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github_ed25519";
      };
      "os161" = {
        hostname = "192.168.122.199";
        user = "hooman";
        identityFile = "~/.ssh/os161";
      };
      "debian" = {
        hostname = "192.168.122.223";
        user = "bigwhoman";
        identityFile = "~/.ssh/debian";
        identitiesOnly = true;
      };
      "CSLab" = {
        hostname = "mlsys-02.syslab.sandbox";
        user = "keshvari";
        identityFile = "~/.ssh/CS";
        identitiesOnly = true;
        proxyJump = "debian";
      };

    };
  };  
  
  programs.fish = {
    enable = true;
    shellInit = ''
# Start tmux automatically if not already in tmux
      if status is-interactive; and not set -q TMUX
        exec tmux
          end
          function fish_user_key_bindings
          fish_vi_key_bindings
          bind -M insert -m default jk backward-char force-repaint
          end 
          '';
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  home.sessionVariables = {
    EDITOR="nvim";
     __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
  };

  home.shellAliases = {
    l = "eza";
    ls = "eza";
    cat = "bat";
  };

}
