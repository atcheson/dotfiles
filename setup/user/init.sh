echo "configuring user $USER with home directory $HOME"
cd $HOME
gem install --user-install homesick
export PATH=$PATH:/$HOME/.gem/ruby/2.1.0/bin/
homesick clone atcheson/dotfiles
homesick symlink dotfiles
vim +PluginInstall +PluginUpdate +qall

zsh $HOME/.zshrc

cabal update
cabal install xmobar
cabal install yeganesh
