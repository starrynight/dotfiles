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

" Filetype sesific
if has('autocmd')
	autocmd  FileType python setlocal  tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftwidth=4 

endif

" To toggle Insert Paste mode in which autoindect is disabled
" Suiteable to pasted formatted code into vim
set pastetoggle=<F2>

" Vim's own backup was designed for 1970', not today
set nobackup

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
set antialias                        " Everyone loves antialias
"set wildmenu                         " Wild menu
"set wildmode=longest,list,full       " Wild menu options
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
"============= Command-T ===================
" Default trigger is
" <Leader>t
"
"============== SuperTab=====================
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"let g:SuperTabDefaultCompletionType = 'context'
"=============== NeoCompleteCache =============
" Use neocomplcache. 
let g:neocomplcache_enable_at_startup = 1
" Use smartcase. 
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion. 
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length. 
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Expand the keyword width
let g:neocomplcache_max_keyword_width = 80
" Expand the filename width
let g:neocomplcache_max_menu_width = 255

let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Define keyword. 
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif

let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Recommended key-mappings. 

" <CR>: close popup and save indent. 
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" <TAB>: completion switching. 
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Plugin key-mappings.
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

"" <LEFT> <Right> can close the pop menu directly
"" <UP> and <Down> will see whether the popup menu exists or not
inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
inoremap <expr><Up>    pumvisible() ? "\<C-p>" : neocomplcache#smart_close_popup() . "\<Up>"
inoremap <expr><Down> pumvisible() ? "\<C-n>" : neocomplcache#smart_close_popup() . "\<Down>"

"=============== UltiSnips =============
let g:UltiSnipsExpandTrigger = "<F3>"
let g:UltiSnipsListSnippets  = "<S-F3>"

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
"
"
"============= CTags and Tagbar ===========
"
let g:tagbar_ctags_bin="/usr/local/bin/ctags"
nnoremap <Leader>tag :!/usr/local/bin/ctags -R --python-kinds=-i *.py<CR>
nnoremap <silent> <Leader>bar :TagbarToggle<CR>
"
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






