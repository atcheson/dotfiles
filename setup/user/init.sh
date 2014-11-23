gem install homesick
homesick clone atcheson/dotfiles
#TODO: backup existing dotfiles
homesick link dotfiles

vim +PluginInstall +PluginUpdate +qall
:

