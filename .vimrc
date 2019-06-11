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
" change the mapleader from \ to ,
let mapleader=','
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" Specify a directory for plugins

" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')


Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'jacoborus/tender.vim'
Plug 'rakr/vim-one'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'crusoexia/vim-monokai'
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'       " To support git info in Airline



Plug 'tomtom/tcomment_vim'
Plug 'scrooloose/nerdtree'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'w0rp/ale'                 " Language lint support

Plug '~/.vim/plugged/YouCompleteMe'


" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme Selection
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set t_Co=256
set termguicolors
"let ayucolor="dark"
"colorscheme ayu
" colorscheme one
" colorscheme palenight
" colorscheme neodark
" colorscheme NeoSolarized
" colorscheme monokai
 colorscheme gruvbox
 set background=dark
 
"

if &t_Co >= 256 && (!has("gui_running"))
"  colorscheme twilight
"	colorscheme vividchalk
"	colorscheme jellybeans
endif

" If in diff mode (vimdiff) use the inkpot color scheme
" that better highlights file differences
if &diff
  colorscheme inkpot    " Vim Tip #1143
endif


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

set wildignore+=*/tmp/*,*.zip,
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

" Tabbing, Default to 4 spaces as tabs
set tabstop=4  			" The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set softtabstop=4		" Sets the number of columns for a TAB
set shiftwidth=4    " Indents will have a width of 4
set expandtab				" Expand TABs to spaces
set smarttab				" Insert spaces or tabs to go to the next indent of the next tabstop when the cursor is at the beginning of a line 

" Set foldmethod
set foldmethod=syntax
set foldmethod=marker
set foldlevel=99

" Vim's own backup was designed for 1970', not today
set nobackup
set autowrite
  


" Filetype sesific
if has('autocmd')
  augroup Indention
	autocmd!
		autocmd BufReadPost .vimrc setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
		autocmd FileType python setlocal    tabstop=4 softtabstop=4 shiftwidth=4 expandtab 
		autocmd FileType swift setlocal     tabstop=4 softtabstop=4 shiftwidth=4 expandtab 
	" Use indent as foldmethod in python.
	" THX to
	" http://stackoverflow.com/questions/357785/what-is-the-recommended-way-to-use-vim-folding-for-python-coding
		autocmd FileType python set foldmethod=indent
	" Do not fold internal statements.
		autocmd FileType python set foldnestmax=2
		autocmd FileType Makefile set noexpandtab
	" C/C++ specific settings
		autocmd FileType c,cpp,cc,cxx set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30
	augroup end

	augroup AutoSave
		autocmd!
		" Vim Tip #1160 - Auto Save files when focus is lost.
		autocmd FocusLost * :wa
	augroup end

	augroup RestorePreviousPosistion
	"Restore cursor to file position in previous editing session
	"Very useful tips 
	"From https://github.com/vgod/vimrc/blob/master/vimrc
		set viminfo='10,\"100,:20,%,n~/.viminfo
		autocmd!
		autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
	augroup end
endif

" To toggle Insert Paste mode in which autoindect is disabled
" Suiteable to pasted formatted code into vim
set pastetoggle=<F2>

" <F3> is reserved for utilsnips

" To toggle line number
nmap <F4> :set number! number?<cr>



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
set ruler                            " Always show current position(row: , col: )
set number                           " Always show line-numbers
set antialias                        " Everyone loves atialias
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



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable omni completion.
if has("autocmd")
  augroup OmniCompletionStart
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup end
endif

"http://stackoverflow.com/questions/903847/prevent-splitting-window-when-using-pythoncomplete-in-vim
set completeopt-=preview
"http://stackoverflow.com/questions/3105307/how-do-you-automatically-remove-the-preview-window-after-autocompletion-in-vim
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"
"=============== YouCompleteMe =============

let g:ycm_key_invoke_completion='<c-z>'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" set tags+=/usr/include/c++/4.8/stdcpp.tags
" if has("autocmd") 
"   augroup YouCompleteMeAutoClose
"     autocmd!
"     autocmd InsertLeave * if pumvisible() == 0|pclose|endif "close autocomplete menu when leaving insert mode
"   augroup end
" endif


let g:ycm_max_num_candidates = 30

let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_seed_identifiers_with_syntax=1
" let g:ycm_cache_omnifunc=0
let g:ycm_autoclose_preview_window_after_completion=1 

set completeopt=menu,menuone
let g:ycm_confirm_extra_conf=0
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_filetype_whitelist = {
			\ "c":1,
      \ "h":1,
			\ "cpp":1,
			\ "objc":1,
			\ "python": 1,
			\ "java": 1,
			\ "sh":1,
			\ "zsh":1,
			\ "zimbu":1,
			\ "vim":1,
      \ "rust":1
			\ }

nnoremap <F5>           :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>gic    :YcmCompleter GoToInclude<CR>
nnoremap <leader>gdc    :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gdf    :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gip    :YcmCompleter GoToImprecise<CR>
nnoremap <leader>f      :YcmCompleter FixIt<CR>



let g:ycm_semantic_triggers={
  \   'c': ['->', '.','re!\w{2}'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s', 're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::','re!\w{2}'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'ruby,rust': ['.', '::','re!\w{2}'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }


let g:ycm_rust_src_path='/home/user/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'





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
  nmap <silent> <C-_> :TComment<CR>
  vmap <silent> <C-_> :TCommentMaybeInline<CR>
  imap <silent> <C-_>  <ESC>:TComment<CR>i
endif

"
"=============== NerdTree ===============
"
map <leader>n :NERDTreeToggle<CR>                                           
"" ignnore .pyc files
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
augroup NerdTreeStart
  autocmd!
  " Automatically close a tab if the only remaining window is NerdTree 
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " Start nerdtree when no file is specified
  autocmd StdinReadPre * let s:std_in=1
  autocmd Vimenter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd Vimenter *.cpp,*.hpp,*.c,*.h,*.cc,*.cxx  NERDTree
augroup End

"
"
"============= CTags/GTags and Tagbar ===========
"
"
set tags=./.tags;,.tags
let $GTAGSLABEL = 'native-pygments'

" enable gtags module
let g:gutentags_modules = ['gtags_cscope']
" " config project root markers.
let g:gutentags_project_root = ['.root','.svn','.git','.hg','.project']
" generate datebases in my cache directory, prevent gtags files polluting my
" project
let g:gutentags_cache_dir = expand('~/.cache/tags')
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
let g:gutentags_define_advanced_commands = 1
let g:gutentags_auto_add_gtags_cscope = 1


" let g:tagbar_width=30
nnoremap <silent> <Leader>b :TagbarToggle<CR>
augroup TagBarStart
  autocmd!
  autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
augroup end

"
"============ CloseTags ===================
"
"
" if has("autocmd")
"   autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
"   autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
"   
" endif 
"
"
"
"
"=========== Airline =======================
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
" The default setting of 'laststatus' is for the statusline to not appear
" until a split is created. If you want it to appear all the time, add the
" following to your vimrc: set laststatus=2
set laststatus=2
set noshowmode  " Disable mode line, all info is provided in air line


"
"=============== ALE ======================
"

let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''



"
"========== Switch Between Header and CC File=========
  map <F6> :call CurtineIncSw()<CR>



"========== Final Touch =============
nnoremap <CR> :noh<CR><CR>:<backspace> " Press Enter will clear search highlight, backspace to clear :noh from status line
" Clear previous highlight
" Mind the double quote and the back slash to escape the special key
call feedkeys(":nohlsearch\<CR>:\<backspace>")
