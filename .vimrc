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
call plug#end()

" Nerd Tree Specific
" ----Map a Key to open NerdTree
map <F2> :NERDTreeToggle<CR>
" ----Start NerdTree if no file is specified on opening Vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" ----Close Vim of only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


set nocompatible
set showmode
"set cursorline
set number
set tabstop=2
set shiftwidth=2
set expandtab
"set listchars=tab:»·,trail:·
set showbreak='^'
set list listchars=tab:»-,eol:↲,nbsp:.,trail:.,extends:>,precedes:<
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

