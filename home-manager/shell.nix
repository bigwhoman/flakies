{ ... }:

{
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

  home.shellAliases = {
    l = "eza";
    ls = "eza";
    cat = "bat";
  };
}
