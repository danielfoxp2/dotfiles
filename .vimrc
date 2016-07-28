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

"Change caps to UPPERCASE in NORMAL and INSERT mode
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea

"Change caps to lowercase in NORMAL and INSERT mode
nnoremap <C-l> guiw
inoremap <C-l> <esc>guiwea

"When search and move around results, show them in the center of window
nnoremap n nzzzv
nnoremap N Nzzzv

"To take off the highlited results of search
nnoremap <BS> :nohlsearch<cr>

"To fast switch between previous and current file
nnoremap <leader><leader> <c-^>

" Remap F5 to change fast between listed buffers
nnoremap <F5> :buffers<CR>:buffer<space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set .feature files as cucumber filetype then set standard 
" indentation for cucumber filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufnewFile,BufReadPost *.feature set filetype=cucumber
autocmd FileType cucumber set ai sw=2 sts=2 et
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTO CREATION OF NON-EXISTENT DIRECTORIES
" Found at http://www.ibm.com/developerworks/library/l-vim-script-5/
" Everytime that a file is edited, if its path contains directories
" inexistent, vim will create those dirs, avoinding the horrible
" E212 - Can't open file for writing.
" If the directory does not exist it will ask if you want to create it
" Very nice...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup AutoMkdir
    autocmd!
    autocmd BufNewFile * :call EnsureDirExists()
augroup END
function! EnsureDirExists()
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        call AskQuit("Directory '" . required_dir . "' doesn't exist.", "&Create it?")
        try 
            call mkdir(required_dir, 'p')
        catch
            call AskQuit("Can't create '" . required_dir . "'", "&Continue anyway?")
        endtry
    endif
endfunction

function! AskQuit(msg, proposed_action)
    if confirm(a:msg, "&Quit?\n" . a:proposed_action) == 1
        exit
    endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we are in the begining of a line. Else, do completion.
" I've changed the name of the function which was InsertTabWrapper()
" Stoled from THE GREAT Gary Bernhardt.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MultiPurposeTab()
    let col = col('.') - 1
    if !col || getline('.')[col -1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
endfunction
inoremap <tab> <c-r>=MultiPurposeTab()<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
" Enables even change file directory while renaming
" Changes vim buffer too
" Stoled from THE GREAT Gary Bernhardt.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_dir = expand('%:h')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name 
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE FOR ELIXIR
" Variation of a function from THE GREAT Gary Bernhardt.
" Need improvement yet. Because I don't know how to work with phoenix
" so the in_app logic is not correct
" 
" need to make it handle with alternate between acceptance too
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
    let new_file = AlternateForCurrentFile()
    exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
    let current_file = expand("%")

    let going_to_acceptance = match(current_file, '\(.feature\|_context.exs\)$') != -1

    if going_to_acceptance
        call DealWithAcceptance()
    else
        call DealWithUnits()
    endif

"    let new_file = current_file
"    let in_spec = match(current_file, '_spec') != -1
"    let going_to_spec = !in_spec
"    let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1
"    if going_to_spec
"        if in_app
"            let new_file = substitute(new_file, '^app/', '', '')
"        end
"        let new_file = substitute(new_file, '\.ex$', '_spec.exs', '')
"        let new_file = substitute(new_file, 'lib/', 'spec/', '')
"    else
"        let new_file = substitute(new_file, '_spec\.exs$', '.ex', '')
"        let new_file = substitute(new_file, 'spec/', 'lib/', '')
"        if in_app
"            let new_file = 'app/' . new_file
"        end
"    endif
"    return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

function! DealWithAcceptance()
endfunction

function! DealWithUnits()
    let current_file = expand("%")
    let new_file = current_file
    let in_spec = match(current_file, '_spec') != -1
    let going_to_spec = !in_spec
    let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1
    if going_to_spec
        if in_app
            let new_file = substitute(new_file, '^app/', '', '')
        end
        let new_file = substitute(new_file, '\.ex$', '_spec.exs', '')
        let new_file = substitute(new_file, 'lib/', 'spec/', '')
    else
        let new_file = substitute(new_file, '_spec\.exs$', '.ex', '')
        let new_file = substitute(new_file, 'spec/', 'lib/', '')
        if in_app
            let new_file = 'app/' . new_file
        end
    endif
    return new_file
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS IN ANOTHER CONTAINER
" Variation of functions from THE GREAT Gary Bernhardt.
" Further improvements: Run tests for elixir and for Javascript too
" To do this, when call ENTER - for example - do a match to see if
" the called file is an elixir or js file. Then call the right function
" to either case
" Probably I will change the ENTER key to space. Way more confortable
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MapCRtoRunTests()
    nnoremap <cr> :call RunTestFile()<cr>
endfunction
call MapCRtoRunTests()
nnoremap <leader>a :call RunTests('')<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif
    call RunTestsForMarkedFile(command_suffix)
endfunction

function! RunTestsForMarkedFile(command_suffix)
    let in_test_file = match(expand("%"), '\(_context.exs\|.feature\|_spec.exs\)$') != -1
    if in_test_file
        call MarkFileAsCurrentTest(a:command_suffix)
    elseif !exists("t:dm_test_file")
        return
    end
    call RunTests(t:dm_test_file)
endfunction

function! MarkFileAsCurrentTest(command_suffix)
    let t:dm_test_file = expand("%:p") . a:command_suffix
endfunction

function! RunTests(filename)
    let g:docker_command = ':!docker exec -it elixir bash -c '
    "Save the file and run tests
    if expand("%") != ""
        :w
    end
    if match(a:filename, '\(_context.exs\|.feature\)$') != -1
        "Como o white_bread tem bastante limitacao entao nao sera possivel
        "executar um unico arquivo feature como pode ser feito em outras
        "implementacoes do cucumber. Portanto, ao identificar os tipos de
        "arquivos acima, sera executada toda suite de features existentes
        let mixPathToRunTests = matchstr(expand("%:p"), '\(.*\)\/apps\/.\{-}\/')
        exec g:docker_command . "\"cd " . mixPathToRunTests . " && mix white_bread.run " . a:filename . "\""
    else
        let mixPathToRunTests = matchstr(expand("%:p"), '\(.*\)\/work\/.\{-}\/')
        exec g:docker_command . "\"cd " . mixPathToRunTests . " && mix espec " . a:filename . "\""
    end
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif 

"remove .netrwhist 
"au VimLeave * if filereadable("[path here]/.netrwhist")|call 
"delete("[path here]/.netrwhist")|endif 
