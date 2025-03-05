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
	

	programs.home-manager.enable = true;
	home.packages = with pkgs; [
		kitty
		wofi
		bat
		fzf
		ripgrep
		jq
		tree
		eza
	];
	
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
