set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'scrooloose/syntastic'
Plugin 'FSwitch'
Plugin 'kien/ctrlp.vim'
Plugin 'myusuf3/numbers.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/nerdcommenter'

filetype plugin indent on

set number
syntax on
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set hlsearch
set incsearch
set mouse=a

let g:syntastic_cpp_check_header = 1
let g:neocomplete#enable_at_startup = 1

inoremap <expr><Tab>  neocomplete#start_manual_complete()
