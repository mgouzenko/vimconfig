mkdir ~/.vim
cp -r ./* ~/.vim
echo "runtime vimrc" > ~/.vimrc

# Vundle is a package manager, used to install packages to .vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install all plugins
vim -C "PluginInstall"

# Good alias to add to bash_profile
echo "alias index='ctags -R --exclude=.git --exclude=log .'" >> ~/.bashrc

# Good alias to add to bashrc
echo "alias index='ctags -R --exclude=.git --exclude=log .'" >> ~/.bash_profile
