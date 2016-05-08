if [ -a "~/.vimrc" ]
then
	  echo "~/.vimrc file detected. Please remove it and re-run this script"
	  exit
fi
mkdir ~/.vim
cp -r ./* ~/.vim
echo "runtime vimrc" > ~/.vimrc

# Vundle is a package manager, used to install packages to .vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install all plugins
vim +PluginInstall +qall

# Good alias to add to bashrc
echo "alias index='ctags -R --exclude=.git --exclude=log .'" >> ~/.bash_profile
