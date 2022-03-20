set nocompatible              " be iMproved, required
filetype off                  " required

set termguicolors

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'Yggdroot/indentLine'
" Plugin 'file:////Users/kinoute/Sites/vim-hivacruz-theme'
Plugin 'kinoute/vim-hivacruz-theme'
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'

" Productivity
Plugin 'tpope/vim-commentary'
Plugin 'zxqfl/tabnine-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mtth/scratch.vim'
Plugin 'romainl/vim-cool'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

Plugin 'w0rp/ale', { 'for': 'rust' }

" Languages and syntax
Plugin 'godlygeek/tabular'
Plugin 'airblade/vim-gitgutter'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'preservim/nerdtree'
Plugin 'sheerun/vim-polyglot'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'uiiaoo/java-syntax.vim'
Plugin 'tpope/vim-rails'
Plugin 'dbestevez/smarty.vim'


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
set nocursorcolumn
set updatetime=100
set cursorline
set incsearch
set hlsearch
set mouse+=a
set showmatch
set clipboard=unnamed
set wildmenu
set norelativenumber

" code folding
set foldmethod=indent
set foldnestmax=10
set foldlevel=1
" set foldcolumn=2

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'hivacruz'
let g:airline_powerline_fonts = 1

" see total matches while searching
let g:CoolTotalMatches = 1

" don't highlight linting messages
let g:ale_set_highlights = 0

" lightline
let g:lightline = {'colorscheme': 'hivacruz'}

" tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" git gutter
let g:gitgutter_highlight_lines = 0

" fzf
let g:fzf_layout = { 'down': '40%' }
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"

map <C-n> :NERDTreeToggle<CR>

"open nerdtree when no argument is passed to vi
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()

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
