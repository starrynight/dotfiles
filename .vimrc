"
"
" Biased for Python
" Reference links:  
" http://nvie.com/posts/how-i-boosted-my-vim/
" http://anderse.wordpress.com/2011/09/07/my-vim-gvim-configuration/


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initialization
"
" Some commands must be initialized at the beginning
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Compatible Mode
"
" VIM full features instead of VI
" When local .vimrc is found, it's default setting.
" Normally, it's only used for global vimrc. 
" However, it does no harm to highlight this in the local 
set nocompatible
"
"
" Pathogen Setting
"
" This must be initiated at the beginning 
"
" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
"
" change the mapleader from \ to ,
let mapleader=','
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing setings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype plugin
filetype plugin on
filetype indent on

" Filetypes and encoding
set fileformats=unix,dos,mac
set encoding=utf-8
set wildignore=.svn,CVS,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.bak,*.pyc 

" 
" General behaviour
""
"set autochdir      " CWD is always same as current file
" But some plugins doesn't work well with this
" It could also mess up with make files
" Alternative method
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file

set autoindent     " Autoident
set copyindent	   " Copy indent from previous line
"set smartindent    " Only needed when file specific auto-indent doesn't work
"set nowrap         " Do not wrap lines
set shiftround	   " Use multiple of shiftwidth when indenting with '<' and '>'
set smarttab 	   " Insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set smartcase      " Smart casing when searching
set ignorecase     " ... or ignore casing
set hlsearch       " Highlight matches
set incsearch      " Modern (wrapping) search
set history=500    " Long undo history
set undolevels=500 " use many muchos levels of undo
"set textwidth=80	"Set max text wrap length

" make backspace a more flexible
set backspace=indent,eol,start

" Disable sounds
set vb t_vb="
set noerrorbells
set visualbell

" Tabbing, Default to 2 spaces as tabs
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Set foldmethod
set foldmethod=syntax
set foldmethod=marker
set foldlevel=99

" Filetype sesific
if has('autocmd')
	autocmd  FileType python setlocal  tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftwidth=4 
" Use indent as foldmethod in python.
" THX to
" http://stackoverflow.com/questions/357785/what-is-the-recommended-way-to-use-vim-folding-for-python-coding
  autocmd FileType python set foldmethod=indent
" Do not fold internal statements.
  autocmd FileType python set foldnestmax=2
	autocmd FileType Makefile set noexpandtab
" C/C++ specific settings
  autocmd FileType c,cpp,cc set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30
endif

" To toggle Insert Paste mode in which autoindect is disabled
" Suiteable to pasted formatted code into vim
set pastetoggle=<F2>

" <F3> is reserved for utilsnips

" To toggle line number
nmap <F4> :set number! number?<cr>
" Vim's own backup was designed for 1970', not today
set nobackup
set autowrite



" Vim Tip #1160 - Auto Save files when focus is lost.
if has('autocmd')
  autocmd FocusLost * :wa

"Restore cursor to file position in previous editing session
"Very useful tips 
"From https://github.com/vgod/vimrc/blob/master/vimrc
  set viminfo='10,\"100,:20,%,n~/.viminfo
  autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
endif


" This one I don't understand
set hidden
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" User interface setings
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
"General Settings
"
set showmatch                        " Show matching braces when over one
set ruler                            " Always show current position
set number                           " Always show line-numbers
set antialias                        " Everyone loves a"tialias
" Get from http://piao-tech.blogspot.com/2008/10/basic-vimrc-file.html
set ttyfast                          " Smoother ReDraw 
set wildmenu                         " Wild menu (in command line)
set wildmode=longest,list,full       " Wild menu options (in command line)
set wildchar=<TAB> " start wild expansion in the command line using <TAB>


set title
" Statusline
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer



" Very nice tip to show invisible symbols
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
"Invisible character colors
highlight NonText guifg=#4a4a59 ctermfg=Grey
highlight SpecialKey guifg=#4a4a59 ctermfg=Grey
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

"Theme Selection
"
if has("gui_running")
  colorscheme mylight "TextMate Twighlight Theme Port
endif

if &t_Co >= 256 && (!has("gui_running"))
  colorscheme twilight
"	colorscheme vividchalk
"	colorscheme jellybeans
endif

" If in diff mode (vimdiff) use the inkpot color scheme
" that better highlights file differences
if &diff
  colorscheme inkpot    " Vim Tip #1143
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &t_Co > 2 || has("gui_running")
  " switch syntax highlighting on, when the terminal has colors
  syntax on
endif

" Turn On all Python syntax highlighting
if has("eval")
  let python_highlight_all = 1
  let python_slow_sync = 1
endif

" Show syntax highlighting groups for word under cursor
" Usage: Ctrl-Shift-P, same as in Textmate
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
if !exists("*synstack")
  return
endif
echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other Key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quickly edit/reload the vimrc file
" This effectively maps the ,ev and ,sv keys to edit/reload .vimrc. (I got this from Derek Wyatt’s .vimrc file.)
nmap <silent>,ev :edit $MYVIMRC<CR>
nmap <silent>,sv :source $MYVIMRC<CR>

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" Easy window navigation
map <C-h> <C-w>h
map <C-k> <C-w>k
map <C-l> <C-w>l

" Fold/Unfold with Shift+Space
" https://github.com/originell/vim-config/blob/master/vimrc
nnoremap <s-space> za
vnoremap <s-space> zf

"
"Tired of clearing highlighted searches by searching for “ldsfhjkhgakjks”?
" Use this:
"nmap <silent> ,/ :nohlsearch<CR> 
"It clears the search buffer when you press ,/
"
"
"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable omni completion.
if has("autocmd")
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
endif

"http://stackoverflow.com/questions/903847/prevent-splitting-window-when-using-pythoncomplete-in-vim
set completeopt-=preview
"http://stackoverflow.com/questions/3105307/how-do-you-automatically-remove-the-preview-window-after-autocompletion-in-vim
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif


"============= Command-T ===================
" Default trigger is
" <Leader>t



"
"=============== YouCompleteMe =============
" Use YMC. 
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" let OmniCpp_DefaultNamespaces = ["_GLIBCXX_STD"]
set tags+=/usr/include/c++/4.8/stdcpp.tags
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "close autocomplete menu when leaving insert mode

let g:ycm_complete_in_comments=1
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_cache_omnifunc=0
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>




"=============== UltiSnips =============
" set runtimepath+=~/.vim/bundle/ultisnips/
let g:UltiSnipsExpandTrigger = "<F3>"
let g:UltiSnipsJumpForwardTrigger="<C-x>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

"=============== Tcomment  =============
" Macvim doesn't pass <C-/> to vim
" Only Command+/ works
if has("gui_macvim")
  noremap <silent> <D-/> :TComment<CR>
  vnoremap <silent> <D-/> :TCommentMaybeInline<CR>'
  inoremap <silent> <D-/> <C-o>:TComment<CR>'
else
" Nomral terminal will map <C-_> to <C-/>
  noremap <silent> <C-_> :TComment<CR>
  vnoremap <silent> <C-_> :TCommentMaybeInline<CR>'
  inoremap <silent> <C-_> <C-o>:TComment<CR>'
endif
"
"
"=============== NerdTree ===============
"

map <leader>n :NERDTreeToggle<CR>                                           
"" ignnore .pyc files
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeAutoDeleteBuffer=1
" Start nerdtree when no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd vimenter *.cpp,*.hpp,*.c,*.h,*.cc,*.cxx  NERDTree


"
"
"============= CTags and Tagbar ===========
"
"
let g:tagbar_ctags_bin="/usr/bin/ctags"
nnoremap <Leader>tag :!/usr/bin/ctags -R --python-kinds=-i *.py<CR>
nnoremap <silent> <Leader>b :TagbarToggle<CR>
let g:tagbar_width=30
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

"
"============ CloseTags ===================
"
"
if has("autocmd")
  autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
  autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
endif 
"
"
"
"
"=========== Airline =======================
let g:airline_theme             = 'powerlineish'
" let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
" Hide separator due to lack of patched font
" let g:airline_left_sep=''
" let g:airline_right_sep=''
" The default setting of 'laststatus' is for the statusline to not appear
" until a split is created. If you want it to appear all the time, add the
" following to your vimrc: set laststatus=2
set laststatus=2


