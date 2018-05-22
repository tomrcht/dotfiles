call plug#begin('~/.vim/plugged')
" Colors scheme & airline
Plug 'hzchirs/vim-material'
Plug 'nanotech/jellybeans.vim'
Plug 'kudabux/vim-srcery-drk'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Languages & syntax
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'keith/swift.vim'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go'
Plug 'alisdair/vim-armasm'

Plug 'roxma/nvim-completion-manager'
"Plug 'Valloric/YouCompleteMe'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" Random shit and stuff
Plug 'ntpeters/vim-better-whitespace'
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'roxma/ncm-clang'
Plug 'w0rp/ale'
call plug#end()

"Remap leader
let mapleader=" "

" Syntax
filetype plugin indent on
syntax enable
set nosmartindent

"Change shell (env variable) for FZF
let $SHELL = '/bin/bash'

" ycm conf file
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0

"Colors
" background contrast
" colorscheme
" italic font
" bold font
if has("termguicolors")
	set termguicolors
endif
set background=dark
set t_Co=256
colorscheme srcery-drk
let g:enable_italic_font = 1
let g:enable_bold_font = 1

"Splits
"Split on right and on below
"Use :s and :v
set splitright
set splitbelow
cabbrev s split
cabbrev v vsplit

" Line numbers
" Relative to the current line
" Smooth scrolling
" warning at 80 columns
" highlight current line
set number
set relativenumber
hi linenr ctermbg=none
set scrolloff=5
set cc=80
set cursorline

"Search
"Search as you type
"Highlight results
"Ignore case
"Use qq to remove the highlight
set incsearch
set hlsearch
set ignorecase
nnoremap qq :nohl<CR>

"Avoid useless redraw
set lazyredraw

"Ignore some extensions in wildmenu
set wildignore+=*.so,*.o,*.swp

"Remap escape
inoremap jj <Esc>

"Remap page moves
"Avoid scrolling one line by one line
noremap <C-J> }
noremap <C-K> {

" Highlight whitespace
" Strip Whitespace
set list
let g:strip_whitespace_on_save=1
highlight ExtraWhitespace ctermbg=red

"Buffers integration
"Buffers can be hidden but still alive
"Limit buffer history for speed
"Switch buffers by using ctrl+h/l
set hidden
set history=500
nnoremap <C-H> :bprev<CR>
nnoremap <C-L> :bnext<CR>

" Highlight matching (), {}, [], <>, ...
set showmatch

"Signcolumns
"Always show it
"Avoid any unwanted background
set signcolumn=yes
hi clear SignColumn

"Vertical split color
hi VertSplit guibg=bg

"Status line
"Always show statusline
"Hide the mode indicator as it is built in Airline
"Hide command while typing
set laststatus=2
set noshowmode
set noshowcmd

"Autocompletion
"Completion with ncm
"Trigger with C-p
"Use tab and S-tab to move between the choices
imap <C-p> <Plug>(cm_force_refresh)
inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
inoremap <expr> <S-Tab> (pumvisible() ? "\<C-p>" : "\<S-Tab>")
let g:cm_auto_popup=0
set shortmess+=c
set completeopt=menu,menuone,noinsert
set pumheight=5

"Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

"Quickfix colors
"Hide this ugly yellow
hi QuickFixLine gui=None guibg=None guifg=None

"Ale colors
"Ale is the syntax processing framework
"Intrusive colors
hi clear ALEErrorSign
hi clear ALEWarningSign
hi ALEErrorSign guifg=Red
hi ALEWarningSign guifg=Orange

"Ale signs
let g:ale_set_highlights=0
let g:ale_sign_error='! '
let g:ale_sign_warning='~ '

"Linters to use
let g:ale_linters={
      \'c': ['clang'],
      \'cpp': ['clang'],
      \}

"Ale C/C++ linting using basic flags
let g:ale_c_clang_options='-Wall -Wextra -Wshadow --std=gnu99 -Iinclude/'
let g:ale_cpp_clang_options='-Wall -Wextra -Wshadow --std=gnu++14 -Iinclude/'

"Airline
"Do not use powerline
"Disable Git tracking
"Mode, Git, Ale errors, Ale warnings, filename
"syntax, file position
let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled=0
let g:airline#extensions#tabline#buffer_min_count=2
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#show_tab_type=0
let g:airline#extensions#default#layout=[
      \ [ 'a', 'error', 'warning', 'b', 'c' ],
      \ [ 'x', 'z' ]
      \ ]
let g:airline#extensions#hunks#enabled=0
let g:airline_section_z=airline#section#create(['%l/%L'])
let g:airline#extensions#tabline#left_sep=''
let g:airline#extensions#tabline#left_alt_sep=''
let g:airline#extensions#tabline#right_sep=''
let g:airline#extensions#tabline#right_alt_sep=''
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#ale#error_symbol='☨ '
let g:airline#extensions#ale#warning_symbol='☨'
let g:airline#extensions#tagbar#enabled=0
let g:airline_symbols.readonly='🔒'
let g:airline_symbols.linenr=''
let g:airline_symbols.maxlinenr=''
let g:airline_symbols.branch=''

"FZF - The fuzzy finder
"Define some shortcuts
"Choose a layout
"Get the good colors
noremap ff :FZF <CR>
let g:fzf_action={
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }
let g:fzf_layout={ 'down': '~30%' }
let g:fzf_colors={
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Normal', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }

"And also the grepper
"Install ag because it is good
nnoremap <Leader>h :Ag<CR>

"And also the buffer switcher
noremap <Leader>j :Buffers <CR>

"And also the commit explorer
noremap <Leader>k :Commits <CR>
noremap <Leader>K :BCommits <CR>

"Nerdtree
"Ignore object and tmp ~files
nnoremap rr :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let NERDTreeIgnore=['\.o$', '\~$']

"Enable project specific stuff
"This is provided using a local .nvimrc
"Secure avoid loading dangerous stuff
set exrc
set secure

"Indentation
set noet ci pi sts=0 sw=4 ts=4
set listchars=tab:\·\ ,trail:~
if !empty($EPITECH_PATH) && getcwd() =~ $EPITECH_PATH
  set sts=0 sw=8 ts=8
endif
