if &t_Co > 1
    syntax enable
endif
filetype indent on
if &term == "Eterm"
   set t_kb=
   fixdel
endif
au BufNewFile,BufRead *.c set nu
au BufNewFile,BufRead *.cpp set nu
au BufNewFile,BufRead *.py set nu

set shiftwidth =3
set cindent
set autoindent
set expandtab
set tabstop=4
set showmatch
set matchtime=7
set tw=80

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

set colorcolumn=80
highlight ColorColumn ctermbg=233

"set t_Co=256
color blurp
autocmd! bufwritepost .vimrc source %

set pastetoggle==<F2>
set clipboard=unnamed

set mouse=a

vnoremap < <gv " better indent
vnoremap > >gv " better indent

set hlsearch
set incsearch
set ignorecase
set smartcase
call pathogen#infect()
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

set nofoldenable
autocmd BufRead,BufNewFile *.log set syntax=log4j
" turn spellchecker on for txt files
autocmd BufRead,BufNewFile *txt setlocal spell
