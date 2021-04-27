set nocompatible              " be iMproved, required
filetype off                  " required

set termguicolors

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'Yggdroot/indentLine'

" Productivity
Plugin 'tpope/vim-commentary'
Plugin 'zxqfl/tabnine-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mtth/scratch.vim'

Plugin 'w0rp/ale', { 'for': 'rust' }

" Languages and syntax
Plugin 'vim-ruby/vim-ruby'
Plugin 'fatih/vim-go'
Plugin 'elzr/vim-json', { 'for': 'json' }
Plugin 'rust-lang/rust.vim', { 'for': 'rust' }
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'StanAngeloff/php.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'preservim/nerdtree'
Plugin 'chr4/nginx.vim'
Plugin 'vim-python/python-syntax'
Plugin 'sheerun/vim-polyglot'
Plugin 'hail2u/vim-css3-syntax'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable

colorscheme hivacruz
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
set completeopt-=preview
set laststatus=2
set noshowmode
set nofoldenable
set updatetime=100

let g:lightline = {
      \ 'colorscheme': 'ayu_mirage',
      \ }

let g:indentLine_leadingSpaceEnabled = 0
" Vim
let g:indentLine_color_term = 239
" GVim
let g:indentLine_color_gui = '#31364a'

" php
let g:php_sql_query = 1
let g:php_html_in_string = 1
let g:php_var_selector_is_identifier = 1

" python
let g:python_highlight_all = 1

map <C-n> :NERDTreeToggle<CR>

" show scope under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" inoremap " ""<left>
" inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


