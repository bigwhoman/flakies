{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Hyprland desktop ---
    waybar
    hyprpaper
    hyprshot
    hyprsunset
    hyprlock
    wlogout
    rofi
    wl-clipboard
    brightnessctl
    playerctl
    mako

    # --- Terminals & CLI tools ---
    kitty
    tmux
    btop
    stow
    bat
    eza
    fzf
    ripgrep
    jq
    tree
    tldr
    killall
    lazygit
    ranger
    p7zip
    unzip
    zip
    pv
    openssl
    sshfs

    # --- System / hardware info ---
    sysstat
    lm_sensors
    gpustat
    dmidecode
    hdparm
    usbutils
    lshw
    bluetui
    ddcutil

    # --- Audio ---
    alsa-utils
    pavucontrol

    # --- C / C++ / Rust dev ---
    gcc
    gnumake
    cmake
    clang-tools
    lldb
    cpplint
    rustup
    wabt
    vscode

    # --- Python ---
    python3

    # --- Formatters (used by nvim) ---
    isort
    black
    prettierd
    stylua

    # --- Docs, papers, LaTeX ---
    texliveFull
    zathura
    pandoc
    papis
    obsidian
    # zotero  # 10.0.4 fails to build on current nixpkgs; re-enable after the next flake update

    # --- Apps ---
    thunar
    brave
    telegram-desktop
    vlc
    spotify
    discord

    # --- AI CLIs ---
    claude-code
    grok-build
  ];
}
