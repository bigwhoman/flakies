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
		wofi
		bat
		waybar
		hyprpaper
		hyprshot
		hyprsunset
		wlogout
		fzf
		ripgrep
		jq
		tree
		eza
		dmidecode
		tldr
		gpustat		
		killall
		lm_sensors
		bluetui
		swaylock-effects
		discord
		wl-clipboard
		brightnessctl
		wireplumber
		rofi-wayland
		arduino-ide
		arduino-cli
		xfce.thunar
		alsa-utils
		pavucontrol
		helvum
		stdenv
    lazygit
    virtualbox
    p7zip
    unzip
    zip
    lshw
    glxinfo
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
    ranger
    tdf
    microsoft-edge
    evince
    obsidian
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
    	};
	
	home.shellAliases = {
		l = "eza";
		ls = "eza";
		cat = "bat";
	};

}
