set nocompatible

"https://github.com/junegunn/vim-plug
"if empty(glob('~/.vim/autoload/plug.vim'))
"      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

filetype plugin on
filetype indent on
call pathogen#infect()
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

set shiftwidth=2
set cindent
set autoindent
set expandtab
set tabstop=2
set showmatch
set matchtime=7
"set tw=80
set rtp+=~/.fzf

autocmd! bufwritepost .vimrc source %

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

if &t_Co > 1
    syntax enable
    set background=dark
    let g:solarized_termtrans = 1
    let g:solarized_visibility="high"
    colorscheme solarized
    "set t_co=16
    "colorscheme blurp
endif


call matchadd('colorcolumn', '\%81v', 100)

set pastetoggle==<F2>
set clipboard=unnamed

"set mouse=a

vnoremap < <gv " better indent
vnoremap > >gv " better indent

set hlsearch
set incsearch
set ignorecase
set smartcase
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set complete+=kspell

" vimwiki with markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]


set foldenable
set cursorline
set cursorcolumn
set laststatus=2

autocmd filetype cpp set foldmethod=syntax
autocmd filetype c set foldmethod=syntax
autocmd filetype py set foldmethod=syntax

autocmd BufRead,BufNewFile *.log set syntax=log4j
" turn spellchecker on for txt files
autocmd BufRead,BufNewFile *txt setlocal spell
autocmd BufRead,BufNewFile *text setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.markdown setlocal spell


autocmd filetype rmd map <f5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>r<space>--vanilla<enter>
autocmd filetype markdown map <f5> :!pandoc<space>'<c-r>%'<space>-o<space>'<c-r>%<bs><bs>pdf'<enter>
"autocmd filetype markdown map <f5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>r<space>--vanilla<enter>
autocmd filetype rmd map <leader><f5> :!mupdf<space>'<c-r>%<bs><bs><bs>pdf'&<enter>
autocmd filetype markdown map <leader><f5> :!mupdf<space>'<c-r>%<bs><bs>pdf'&<enter>

"navigating with guides
    inoremap <space><tab> <esc>/<++><enter>"_c4l
    vnoremap <space><tab> <esc>/<++><enter>"_c4l
    map <space><tab> <esc>/<++><enter>"_c4l
    inoremap ;qjk <++>

"""php
    autocmd filetype php,html inoremap ;b <b></b><space><++><esc>fbt>i
    autocmd filetype php,html inoremap ;i <em></em><space><++><esc>fet>i
    autocmd filetype php,html inoremap ;h1 <h1></h1><enter><enter><++><esc>2kf<i
    autocmd filetype php,html inoremap ;h2 <h2></h2><enter><enter><++><esc>2kf<i
    autocmd filetype php,html inoremap ;h3 <h3></h3><enter><enter><++><esc>2kf<i
    autocmd filetype php,html inoremap ;p <p></p><enter><enter><++><esc>02kf>a
    autocmd filetype php,html inoremap ;a <a<space>href=""><++></a><space><++><esc>14hi
    autocmd filetype php,html inoremap ;e <a<space>target="_blank"<space>href=""><++></a><space><++><esc>14hi
    autocmd filetype php,html inoremap ;ul <ul><enter><li></li><enter></ul><enter><enter><++><esc>03kf<i
    autocmd filetype php,html inoremap ;li <esc>o<li></li><esc>f>a
    autocmd filetype php,html inoremap ;ol <ol><enter><li></li><enter></ol><enter><enter><++><esc>03kf<i
    autocmd filetype php,html inoremap ;im <table<space>class="image"><enter><caption align="bottom"></caption><enter><tr><td><a<space>href="pix/<++>"><img<space>src="pix/<++>"<space>width="<++>"></a></td></tr><enter></table><enter><enter><++><esc>4kf>a
    autocmd filetype php,html inoremap ;td <td></td><++><esc>fdcit
    autocmd filetype php,html inoremap ;tr <tr></tr><enter><++><esc>kf<i
    autocmd filetype php,html inoremap ;th <th></th><++><esc>fhcit
    autocmd filetype php,html inoremap ;tab <table><enter></table><esc>o
    autocmd filetype php,html inoremap ;gr <font color="green"></font><esc>f>a
    autocmd filetype php,html inoremap ;rd <font color="red"></font><esc>f>a
    autocmd filetype php,html inoremap ;yl <font color="yellow"></font><esc>f>a
    autocmd filetype php,html inoremap ;dt <dt></dt><enter><dd><++></dd><enter><++><esc>2kcit
    autocmd filetype php,html inoremap ;dl <dl><enter><enter></dl><enter><enter><++><esc>3kcc
    "autocmd filetype php,html inoremap -- &ndash;
    "autocmd filetype php,html inoremap --- &mdash;

"markdown
    autocmd filetype markdown,rmd inoremap ;n ---<enter><enter>
    autocmd filetype markdown,rmd inoremap ;b ****<++><esc>F*hi
    autocmd filetype markdown,rmd inoremap ;u ____<++><esc>F_hi
    autocmd filetype markdown,rmd inoremap ;s ~~~~<++><esc>F~hi
    autocmd filetype markdown,rmd inoremap ;e **<++><esc>F*i
    autocmd filetype markdown,rmd inoremap ;c ``<++><esc>F`i
    autocmd filetype markdown,rmd inoremap ;h ====<space><++><esc>F=hi
    autocmd filetype markdown,rmd inoremap ;i ![](<++>)<++><esc>F[a
    autocmd filetype markdown,rmd inoremap ;a [](<++>)<++><esc>F[a
    autocmd filetype markdown,rmd inoremap ;1 #<space><enter><enter><++><esc>kkA
    autocmd filetype markdown,rmd inoremap ;2 ##<space><enter><enter><++><esc>kkA
    autocmd filetype markdown,rmd inoremap ;3 ###<space><enter><enter><++><esc>kkA
    autocmd filetype markdown,rmd inoremap ;4 ####<space><enter><enter><++><esc>kkA
    autocmd filetype markdown,rmd inoremap ;5 #####<space><enter><enter><++><esc>kkA
    autocmd filetype markdown,rmd inoremap ;6 ######<space><enter><enter><++><esc>kkA
    autocmd filetype markdown,rmd inoremap ;l --------<enter>
    autocmd Filetype markdown,rmd inoremap ;g ```<Enter><Enter>```<Enter><++><Esc>kkA

    autocmd filetype cpp,c inoremap ;" ""<++><esc>F"i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" here begins my automated wordcount addition.
" this combines several ideas from:
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:word_count="<unknown>"
function! WordCount()
    return g:word_count
endfunction

function! UpdateWordCount()
    let lnum = 1
    let n = 0
    while lnum <= line('$')
        let n = n + len(split(getline(lnum)))
        let lnum = lnum + 1
    endwhile
    let g:word_count = n
endfunction

" update the count when cursor is idle in command or insert mode.
" update when idle for 1000 msec (default is 4000 msec).
set updatetime=1000

augroup wordcounter
    au! cursorhold,cursorholdi * call UpdateWordCount()
augroup end


" set statusline, shown here a piece at a time
"set statusline=%1*          " switch to user1 color highlight
set statusline=%<%f            " file name, cut if needed at start
set statusline+=%m          " modified flag
set statusline+=%y          " file type
set statusline+=%=          " separator from left to right justified
set statusline+=\ %{WordCount()}\ words,
set statusline+=\ %l/%l\ lines,\ %p " percentage through the file

" highlight the status bar when in insert mode
hi statusline cterm=NONE ctermbg=NONE ctermfg=blue
au insertenter * hi statusline cterm=reverse ctermfg=Black ctermbg=blue
au insertleave * hi statusline cterm=NONE ctermbg=NONE ctermfg=blue

let @t='ggi---title:  <++> <++>author: Jeffery Williams---\tableofcontentsPLANNING: <++>'
let @d='/^\/\/[ ]*DESCRIPTION0ls*!j0/\/\/\*kls */\/\/\*k$a/'
let @l='ggi# :pu=strftime(\"%Y-%b-%d %a\")kJA <++>- <++>'
