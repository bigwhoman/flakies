{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    # yq-go: papis.nvim converts papis info.yaml files to JSON with it.
    extraPackages = [ pkgs.tree-sitter pkgs.yq-go ];
    # init.lua is stowed from ~/dotfiles; load HM's generated lua via the wrapper instead.
    sideloadInitLua = true;
    # sqlite.lua (papis.nvim dep) can't find libsqlite3 on NixOS without this.
    initLua = ''
      vim.g.sqlite_clib_path = "${pkgs.sqlite.out}/lib/libsqlite3.so"
    '';
  };
}
