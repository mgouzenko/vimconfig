#!/bin/bash
if [ -e "$HOME/.vimrc" ]; then
	echo "~/.vimrc detected, aborting"
	exit
fi

# Vundle is a package manager, used to install packages to .vim/bundle
# TODO: make it a submodule
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install all plugins
vim +PluginInstall +qall

# Good alias to add to bashrc
echo "alias index='ctags -R --exclude=.git --exclude=log .'" >> ~/.bash_profile
