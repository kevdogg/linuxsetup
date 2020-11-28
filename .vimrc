set encoding=utf-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-plug'
Plug 'https://github.com/kshenoy/vim-signature.git'
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'Shougo/unite.vim'
Plug 'Quramy/vison'
call plug#end()

" Nerd Tree Specific
" ----Map a Key to open NerdTree
map <F2> :NERDTreeToggle<CR>
" ----Start NerdTree if no file is specified on opening Vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" ----Close Vim of only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


let g:indentLine_enabled = 0
"let g:indentLine_leadingSpacChar='.'
"let g:indentLine_leadingSpaceEnabled='1'

set nocompatible
set showmode
"set cursorline
set number
set tabstop=2
set shiftwidth=2
set expandtab
set list
"set listchars=tab:»·,trail:·
"set showbreak='^'
"set listchars=tab:»-,eol:↲,nbsp:.,trail:.,extends:>,precedes:<
set showbreak=↪\ 
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set ignorecase
set smartcase
set ruler
set autoindent
set copyindent
set showmatch
set smarttab
set hlsearch
set incsearch
set undolevels=1000
set history=1000
set showcmd
set ruler
set softtabstop=2
set statusline=%f\ -\ FileType:\ %y
set laststatus=2

" Highlighting Toggle F3
set hlsearch
hi Search guifg=White guibg=LightBlue
hi Search term=reverse ctermfg=White ctermbg=LightBlue
nnoremap <F3> :set hlsearch! hlsearch?<CR>

" Fold Toggle - F9
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Set folding for comments - zo, zc open/close block, zi toggles global
" folding on/off - See https://www.rtfm-sarl.ch/articles/hide-comments.html#:~:text=Using%20folds%20to%20hide%20comments,txt%22.
"autocmd FileType vimrc set fdm=expr fde=getline(v:lnum)=~'^\\s"'?1:getline(prevnonblank(v:lnum))=~'^\\s"'?1:getline(nextnonblank(v:lnum))=~'^\\s*"'?1:0

"autocmd FileType c set fdm=expr fde=getline(v:lnum)=~'^\\s#'?1:getline(prevnonblank(v:lnum))=~'^\\s#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0
set fdm=expr fde=getline(v:lnum)=~'^\\s#'?1:getline(prevnonblank(v:lnum))=~'^\\s#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

if has("statusline")
 "set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
  set statusline=
  set statusline+=%7*\[%n]                                  "buffernr
  set statusline+=%1*\ %<%F\                                "File+path
  set statusline+=%2*\ %y\                                  "FileType
  set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
  set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
  set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
  set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
  set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
  set statusline+=%9*\ col:%03c\                            "Colnr
  set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
endif
