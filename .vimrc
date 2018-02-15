set nocompatible
filetype plugin on
if &t_Co > 1
    syntax enable
endif
filetype indent on
if &term == "Eterm"
   set t_kb=
   fixdel
endif
"au BufNewFile,BufRead *.c set nu
"au BufNewFile,BufRead *.cpp set nu
"au BufNewFile,BufRead *.py set nu
set number relativenumber
set encoding=utf-8

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set shiftwidth=4
set cindent
set autoindent
set expandtab
set tabstop=4
set showmatch
set matchtime=7
"set tw=80

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

set colorcolumn=100

"set t_Co=256
color blurp
autocmd! bufwritepost .vimrc source %

set pastetoggle==<F2>
set clipboard=unnamed

"set mouse=a

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

" vimwiki with markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]


set nofoldenable
autocmd BufRead,BufNewFile *.log set syntax=log4j
" turn spellchecker on for txt files
autocmd BufRead,BufNewFile *txt setlocal spell
autocmd BufRead,BufNewFile *text setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.rmd setlocal spell
autocmd BufRead,BufNewFile *.markdown setlocal spell
autocmd filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
autocmd filetype markdown map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
autocmd filetype rmd map <leader><F5> :!mupdf<space>'<c-r>%<bs><bs><bs>pdf'&<enter>
autocmd filetype markdown map <leader><F5> :!mupdf<space>'<c-r>%<bs><bs>pdf'&<enter>


"Navigating with guides
    inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
    vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
    map <Space><Tab> <Esc>/<Enter>"_c4l
    inoremap ;qjk <++>

"""PHP
    autocmd FileType php,html inoremap ;b <b></b><Space><++><Esc>FbT>i
    autocmd FileType php,html inoremap ;i <em></em><Space><++><Esc>FeT>i
    autocmd FileType php,html inoremap ;h1 <h1></h1><Enter><Enter><++><Esc>2kf<i
    autocmd FileType php,html inoremap ;h2 <h2></h2><Enter><Enter><++><Esc>2kf<i
    autocmd FileType php,html inoremap ;h3 <h3></h3><Enter><Enter><++><Esc>2kf<i
    autocmd FileType php,html inoremap ;p <p></p><Enter><Enter><++><Esc>02kf>a
    autocmd FileType php,html inoremap ;a <a<Space>href=""><++></a><Space><++><Esc>14hi
    autocmd FileType php,html inoremap ;e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
    autocmd FileType php,html inoremap ;ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
    autocmd FileType php,html inoremap ;li <Esc>o<li></li><Esc>F>a
    autocmd FileType php,html inoremap ;ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
    autocmd FileType php,html inoremap ;im <table<Space>class="image"><Enter><caption align="bottom"></caption><Enter><tr><td><a<space>href="pix/<++>"><img<Space>src="pix/<++>"<Space>width="<++>"></a></td></tr><Enter></table><Enter><Enter><++><Esc>4kf>a
    autocmd FileType php,html inoremap ;td <td></td><++><Esc>Fdcit
    autocmd FileType php,html inoremap ;tr <tr></tr><Enter><++><Esc>kf<i
    autocmd FileType php,html inoremap ;th <th></th><++><Esc>Fhcit
    autocmd FileType php,html inoremap ;tab <table><Enter></table><Esc>O
    autocmd FileType php,html inoremap ;gr <font color="green"></font><Esc>F>a
    autocmd FileType php,html inoremap ;rd <font color="red"></font><Esc>F>a
    autocmd FileType php,html inoremap ;yl <font color="yellow"></font><Esc>F>a
    autocmd FileType php,html inoremap ;dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
    autocmd FileType php,html inoremap ;dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
    "autocmd FileType php,html inoremap -- &ndash;
    "autocmd FileType php,html inoremap --- &mdash;

"MARKDOWN
    autocmd Filetype markdown,rmd inoremap ;n ---<Enter><Enter>
    autocmd Filetype markdown,rmd inoremap ;b ****<++><Esc>F*hi
    autocmd Filetype markdown,rmd inoremap ;s ~~~~<++><Esc>F~hi
    autocmd Filetype markdown,rmd inoremap ;e **<++><Esc>F*i
    autocmd Filetype markdown,rmd inoremap ;h ====<Space><++><Esc>F=hi
    autocmd Filetype markdown,rmd inoremap ;i ![](<++>)<++><Esc>F[a
    autocmd Filetype markdown,rmd inoremap ;a [](<++>)<++><Esc>F[a
    autocmd Filetype markdown,rmd inoremap ;1 #<Space><Enter><Enter><++><Esc>kkA
    autocmd Filetype markdown,rmd inoremap ;2 ##<Space><Enter><Enter><++><Esc>kkA
    autocmd Filetype markdown,rmd inoremap ;3 ###<Space><Enter><Enter><++><Esc>kkA
    autocmd Filetype markdown,rmd inoremap ;4 ####<Space><Enter><Enter><++><Esc>kkA
    autocmd Filetype markdown,rmd inoremap ;5 #####<Space><Enter><Enter><++><Esc>kkA
    autocmd Filetype markdown,rmd inoremap ;6 ######<Space><Enter><Enter><++><Esc>kkA
    autocmd Filetype markdown,rmd inoremap ;l --------<Enter>
    autocmd Filetype markdown,rmd inoremap ;c ```<Enter><++><Enter>```<Esc>kkA
