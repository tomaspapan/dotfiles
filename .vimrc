
" operational settings
set rtp+=$HOME/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2
syntax on
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set number                    " line numbers
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
"           |   |
"           |   + maximum size of register - 500 lines
"           + Information stored about last (max) 50 files

set undodir=~/.vim/undodir
set undofile
set undolevels=1024
set undoreload=65538
set title


" shortcut's for C programming
ab #d #define
ab #i #include
ab #t typedef
ab intmain int main(int argc, char **argv)

" Settings for taglist.vim
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=0
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 1

" tabs
" (LocalLeader is ",")
map <LocalLeader>C  :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q<cr><cr>
map <LocalLeader>r :e ~/.vimrc<cr>
map <LocalLeader>t :e ~/TODO<cr>
map <LocalLeader>b :call BufferList()<CR>  
map <LocalLeader>n :NERDTreeToggle<CR>  
map <LocalLeader>d :call DarkTheme()<CR>  
map <LocalLeader>l :call LightTheme()<CR>  
map <LocalLeader>m :call SmyckTheme()<CR>  

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


if has("gui_running")
    set guioptions-=T       " no toolbar
    set cursorline          " show the cursor line
    set guifont=Menlo\ for\ Powerline:h12
    set lines=50
    set columns=120
end

colorscheme smyck      " macvim == win

set backupskip=/tmp/*,/private/tmp/*" 


" init
set runtimepath+=$HOME/.vim/bundle/vim-pathogen/
runtime autoload/pathogen.vim                                                      
call pathogen#infect('bundle/{}')                                                           
call pathogen#helptags() 

function! DarkTheme()
        set background=dark
        colorscheme solarized
endfunction


function! LightTheme()
        set background=light
        colorscheme solarized
endfunction

function! SmyckTheme()
        colorscheme smyck
endfunction

"nerdtree
let NERDTreeQuitOnOpen=1



