{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [ 
	git
	openssh
	neovim-qt
	xsel
	neovim
	nodejs_22
    ];
}
