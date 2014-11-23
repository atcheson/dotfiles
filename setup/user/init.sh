gem install homesick
homesick clone atcheson/dotfiles
homesick symlink dotfiles
vim +PluginInstall +PluginUpdate +qall

zsh $HOME/.zshrc
