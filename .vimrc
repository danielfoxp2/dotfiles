set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Bundle 'VundleVim/Vundle.vim'
  Bundle 'altercation/vim-colors-solarized.git'                                                                                                                     
  Bundle 'romainl/apprentice'                                                                                                                                       
  Bundle 'tpope/vim-surround'
  Bundle 'ctrlpvim/ctrlp.vim'
  Bundle 'elixir-lang/vim-elixir'
call vundle#end()

set runtimepath^=~/.vim/bundle/ctrlp.vim

set t_Co=256
set t_ut=
let g:solarized_termcolors=256
syntax enable
set background=dark
"colorscheme solarized
color xoria256
"color iceberg
"colorscheme apprentice

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set encoding=utf-8
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hidden		" Hide buffers when they are abandoned
set number		" Show line numbers
set relativenumber	" Show relative line numbers where cursor is
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set laststatus=2
set hlsearch
set ignorecase
set smartcase
set cursorline
set cmdheight:1
set switchbuf=useopen
set showtabline=2
set winwidth=79
set shell=bash
"set t_ti= t_te=
set scrolloff=3 "Seems to be the way to show lines above/below the cursor
set nobackup
set autoread "Reload a file without asking when it is changed outside vim.
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backspace=indent,eol,start
filetype plugin indent on
set wildmode=longest,list
"set wildmenu
set timeout timeoutlen=1000 ttimeoutlen=100
"au FocusLost * :wa "Save automatically when focus is lost
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod=':t'

let g:bufferline_echo=0


" Mapping jj to ESC to go back to normal mode
inoremap jj <Esc>
"nnoremap <tab> % map tab to match S-%
"vnoremap <tab> %
let mapleader=","
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

inoremap <up> <nop>
inoremap <left> <ESC>
inoremap <down> <nop>
inoremap <right> <nop>

nnoremap ; :

nnoremap <leader>ev <C-w><C-v><C-w><C-w><cr>

"Change caps to UPPERCASE
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea

"Change caps to lowercase
nnoremap <C-l> guiw
inoremap <C-l> <esc>guiwea

"When search and move around results, show them in the center of window
nnoremap n nzzzv
nnoremap N Nzzzv

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif 

"remove .netrwhist 
"au VimLeave * if filereadable("[path here]/.netrwhist")|call 
"delete("[path here]/.netrwhist")|endif 
