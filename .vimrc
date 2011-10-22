" Based on http://nvie.com/posts/how-i-boosted-my-vim/
"

set nocompatible

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

if &t_Co >= 256 || has("gui_running")
    colorscheme twilight
"	colorscheme vividchalk
"	colorscheme jellybeans
endif

if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   syntax on
endif


" change the mapleader from \ to ,
let mapleader=','

" Quickly edit/reload the vimrc file
" This effectively maps the ,ev and ,sv keys to edit/reload .vimrc. (I got this from Derek Wyatt’s .vimrc file.)
nmap <silent>,ev :edit $MYVIMRC<CR>
nmap <silent>,sv :source $MYVIMRC<CR>

" These are some of the most basic settings that you probably want to enable, too:
"set nowrap        " don't wrap lines // I think it's a good feature though
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
"set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type



set pastetoggle=<F2>


"let python_highlight_all=1

if has("eval")
  let python_highlight_all = 1
  let python_slow_sync = 1
endif
 
