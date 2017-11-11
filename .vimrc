syntax on
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set hidden
set noautowrite               " don't automagically write on :next
set lazyredraw                " don't redraw when don't have to
set showmode
set showcmd
set nocompatible              " vim, not vi
set autoindent smartindent    " auto/smart indent
set expandtab                 " expand tabs to spaces
set smarttab                  " tab and backspace are smart
set tabstop=4                 " 4 spaces
set shiftwidth=4
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set backspace=indent,eol,start
set showfulltag               " show full completion tags
set noerrorbells              " no error bells please
set linebreak
set cmdheight=1               " command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion
set ttyfast                   " we have a fast terminal
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
compiler ruby                 " Enable compiler support for ruby
set wildmode=longest:full
set wildignore+=*.o,*~,.lo    " ignore object files
set wildchar=<Tab>
set wildmenu                  " menu has tab completion
let maplocalleader=','        " all my macros start with ,
set backup
set backupdir=~/.vim/backup,.,~/
set directory=~/.vim/tmp,~/tmp,.,/tmp
set confirm
set viminfo='50,\"500
set undodir=~/.vim/undodir
set undofile
set undolevels=1024
set undoreload=65538
set title
set path+=**
set statusline=%=%f\ %P\ %m
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set laststatus=2
set noshowmode

" tabs
" (LocalLeader is ",")
map <LocalLeader>c  :!ctags -R --C++-kinds=+cdefglmnpstuv --C-kinds=+cdefglmnpstuv --fields=+iaS --extra=+q<cr><cr>
map <LocalLeader>n :NERDTreeToggle<CR>
map <LocalLeader>s :call SpellcheckON()<cr>
map <LocalLeader>d :call SpellcheckOFF()<cr>
map <LocalLeader>r :edit ~/.vimrc<cr>
nmap <LocalLeader>b :Buffers<CR>
nmap <LocalLeader>f :Files<CR>
nmap <LocalLeader>t :Tags<CR>
nmap <LocalLeader>k :Ack! "\b<cword>\b" <CR>
nmap <LocalLeader>x :cclose <CR>

" mouse stuffs
set mouse=a                   " mouse support in all modes
set mousehide                 " hide the mouse when typing
" map <MouseMiddle> <esc>"*p

"  searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync

set backupskip=/tmp/*,/private/tmp/*"

" init
set nocompatible              " be iMproved, required
filetype off                  " required
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/goyo.vim'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
call plug#end()
filetype plugin indent on

" nerdtree
let NERDTreeQuitOnOpen=1

"ack
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

"gitgutter
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" colorscheme
set background=dark
hi javaRepeat ctermfg = green
hi javaType ctermfg = green
hi javaStorageClass ctermfg = green cterm=bold
hi javaDocTags ctermfg = green
hi Conditional ctermfg = green
hi LineNr ctermfg = magenta
hi Comment ctermfg = red
hi Statement ctermfg = blue
hi Function ctermfg = blue
hi Identifier ctermfg = blue
hi Exception ctermfg = green
hi Special ctermfg = green
hi String ctermfg = yellow
hi MatchParen ctermbg=none cterm=underline ctermfg=magenta
hi StatusLine ctermbg=none cterm=bold ctermfg=black
hi VertSplit ctermfg = none

" shortcut's for C programming
ab #d #define
ab #i #include
ab #t typedef
ab intmain int main(int argc, char **argv)

" functions
function! SpellcheckON()
	setlocal spell spelllang=en_us
endfunction

function! SpellcheckOFF()
	set nospell
endfunction

function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
endfunction

command! ProseMode call ProseMode()
