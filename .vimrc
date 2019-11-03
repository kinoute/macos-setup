set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'luochen1990/rainbow'
Plugin 'itchyny/lightline.vim'

" Productivity
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'zxqfl/tabnine-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plugin 'mtth/scratch.vim'

Plugin 'w0rp/ale', { 'for': 'rust' }

" Languages and syntax
Plugin 'vim-ruby/vim-ruby'
Plugin 'fatih/vim-go'
Plugin 'elzr/vim-json', { 'for': 'json' }
Plugin 'rust-lang/rust.vim', { 'for': 'rust' }
Plugin 'tpope/vim-markdown'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
set path+=**
set backspace=indent,eol,start
set wildmenu
set number
set encoding=utf-8
set background=dark
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
let g:rainbow_active = 1
set completeopt-=preview
set laststatus=2
set noshowmode
map <C-n> :NERDTreeToggle<CR>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


