" My vimrc file

call pathogen#runtime_append_all_bundles() 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" Indenting *******************************************************************
set softtabstop=3
set shiftwidth=3
set tabstop=3
set expandtab
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)
" Searching *******************************************************************
set hlsearch  " highlight search
set incsearch  " Incremental search, search as you type
set ignorecase " Ignore case when searching 
set smartcase " Ignore case when searching lowercase
" Status Line *****************************************************************
set showcmd
set ruler " Show ruler
" Line Wrapping ***************************************************************
set nowrap
set linebreak  " Wrap at word
set numberwidth=4
" Cursor highlights ***********************************************************
set cursorline
" Misc settings ***************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
set nofoldenable " Turn off folding 
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Invisible characters *********************************************************
set listchars=trail:.,tab:>-,eol:$
set nolist
" Enable file type detection
filetype off
filetype plugin indent on
" Enable syntax highlighting
syntax on
"" use emacs-style tab completion when selecting files, etc
" set wildmode=longest,list
"" make tab completion for files/buffers act like bash
" set wildmenu
let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
colorscheme tir_black

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI MODE CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scrollbars ******************************************************************
set sidescrolloff=2
set siso=2

set go-=L
set go-=r

if has('gui_running')
    set guioptions-=T   " Get rid of toolbar "
    set guioptions-=m   " Get rid of menu    "
endif
" Set the font when working in Gvim (mac or linux)
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux"
 	set gfn=Inconsolata-g\ Medium\ 15
else
  set gfn=Monaco:h14
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert New Line *************************************************************
map <S-Enter> O<ESC> " awesome, inserts new line without going into insert mode
"map <Enter> o<ESC>
imap <C-Enter> <ESC>o "seems not working in urxvt
:noremap <Leader>i :set list!<CR> " Toggle invisible chars
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/ " Quick replace current selection
" Navigation ******************************************************************
" Make cursor move by visual lines instead of file lines (when wrapping)
"map <up> gk
map k gk
"imap <up> <C-o>gk
"map <down> gj
map j gj
"imap <down> <C-o>gj
map E ge
" Clean the last search string
map ,c :let @/ = ""<CR>
map <Leader>p <C-^> " Go to previous file
" Hard to type *****************************************************************
imap jj <Esc> " Professor VIM says '87% of users prefer jj over esc', jj abrams disagrees
imap § ()<left>
imap ` _
imap `` ()<left>
imap ``` ();<left><left>
"
" Dont allow arrow keys, we are in vim!
"
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM HOOKS/AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd BufReadPost *.vorg "kuku"
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml,javascript,sass set ai sw=2 sts=2 et
  autocmd FileType html,javascript,css,cucumber,jade,haml set ai sw=3 sts=3 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif
  autocmd BufNewFile,BufRead *.json set ft=javascript
  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off
  autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SPECIFIC CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TAGBAR
nmap <F8> :TagbarToggle<CR>
" CTRLP
let g:ctrlp_working_path_mode = 0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/vendor/*
let g:ctrlp_custom_ignore = 'vendor/bundle'
let g:ctrlp_custom_ignore = '^vendor'
let g:ctrlp_custom_ignore = 'vendor/bundle$'
let g:ctrlp_custom_ignore = '\.git/'
" prevent deleting words when C-w in insert mode.. actually - do C-w
imap <C-w> <ESC><C-w>

" Changes for vim-powerline
let g:Powerline_symbols = 'fancy'
set laststatus=2
set encoding=utf-8

