vimrc
======

My vimrc configuration


installation
============

    git clone --recursive git://github.com/nacitar/vimrc.git "$HOME/.vim"
	"$HOME/.vim/install.sh"

NOTE: this WILL overwrite any existing vimrc!


notes
=====
Vundle will fail to update itself using :BundleInstall! due to being in a submodule.
To update it, from the .vim/ folder, do:

	git submodule update
