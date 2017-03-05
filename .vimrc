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
map <LocalLeader>c  :!ctags -R --C++-kinds=+cdefglmnpstuv --C-kinds=+cdefglmnpstuv --fields=+iaS --extra=+q<cr><cr>
map <LocalLeader>r :e ~/.vimrc<cr>
map <LocalLeader>b :call BufferList()<CR>
map <LocalLeader>n :NERDTreeToggle<CR>
map <LocalLeader>s :call SpellcheckON()<cr>
map <LocalLeader>x :call SpellcheckOFF()<cr>
map <LocalLeader>t :TagbarToggle<cr>

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

colorscheme smyck      " macvim == win

set backupskip=/tmp/*,/private/tmp/*"

" init
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'scrooloose/nerdtree'
Plugin 'roblillack/vim-bufferlist'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'majutsushi/tagbar'
Plugin 'bronson/vim-trailing-whitespace'
call vundle#end()            " required
filetype plugin indent on

function! SpellcheckON()
        setlocal spell spelllang=en_us
endfunction

function! SpellcheckOFF()
        set nospell
endfunction

"nerdtree
let NERDTreeQuitOnOpen=1

set completeopt=menu
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_globlist = ['~/devel/*','!~/*']
autocmd FileType c,cpp,objc,objcpp,python,cs nnoremap <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
