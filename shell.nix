{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/24.05.tar.gz") {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [ 
	git
	openssh
	neovim-qt
	xsel
	neovim
	nodejs_22
	curl
    	element-desktop
	wl-clipboard
	ripgrep
	less
    ];
}
