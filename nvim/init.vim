call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" General {{{
	" Abbreviations
	abbr funciton function
	abbr teh the
	abbr tempalte template
	abbr fitler filter
	abbr cosnt const
	abbr attribtue attribute
	abbr attribuet attribute

	set autoread " detect when a file is changed

	set history=1000 " change history to 1000
	set textwidth=120

	set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
	set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

	if (has('nvim'))
		" show results of substition as they're happening
		" but don't open a split
		set inccommand=nosplit
	endif

	"set backspace=indent,eol,start " make backspace behave in a sane manner
	set clipboard=unnamed

	" Searching
	set ignorecase " case insensitive searching
	set smartcase " case-sensitive if expresson contains a capital letter
	set hlsearch " highlight search results
	set incsearch " set incremental search, like modern browsers
	set nolazyredraw " don't redraw while executing macros

	set magic " Set magic on, for regex

	" error bells
	set noerrorbells
	set visualbell
	set t_vb=
	set tm=500
" }}}

" Appearance {{{
	set cursorline
	set number " show line numbers
	set relativenumber
	"set wrap " turn on line wrapping
	"set wrapmargin=8 " wrap lines when coming within n characters from side
	"set linebreak " set soft wrapping
	"set showbreak=… " show ellipsis at breaking
	set ttyfast " faster redrawing
	set diffopt+=vertical
	set laststatus=2 " show the satus line all the time
	set so=7 " set 7 lines to the cursors - when moving vertical
	set wildmenu " enhanced command line completion
	set hidden " current buffer can be put into background
	set showcmd " show incomplete commands
	set noshowmode " don't show which mode disabled for PowerLine
	set wildmode=list:longest " complete files like a shell
	set scrolloff=5 " lines of text around cursor
	set shell=$SHELL
	set cmdheight=1 " command bar height
	set title " set terminal title
	set showmatch " show matching braces

	" Tab control
	set autoindent
	set noexpandtab " insert tabs rather than spaces for <Tab>
	set tabstop=4 " the visible width of tabs
	set shiftwidth=4 " number of spaces to use for indent and unindent
	"set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
	"set softtabstop=4 " edit as if the tabs are 4 characters wide
	"set shiftround " round indent to a multiple of 'shiftwidth'

	" code folding settings
	set foldmethod=syntax " fold based on indent
	set foldlevelstart=99
	set foldnestmax=10 " deepest fold is 10 levels
	set nofoldenable " don't fold by default
	set foldlevel=1

	" toggle invisible characters
	set list
	set listchars=tab:\·\ ,trail:~,extends:❯,precedes:❮

	set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
	" switch cursor to line when in insert mode, and block when not
	set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
	\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
	\,sm:block-blinkwait175-blinkoff150-blinkon175

	if &term =~ '256color'
		" disable background color erase
		set t_ut=
	endif

	" enable 24 bit color support if supported
	if (has('mac') && empty($TMUX) && has("termguicolors"))
		set termguicolors
	endif

	" highlight conflicts
	match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

	" LightLine {{{
		Plug 'itchyny/lightline.vim'
		let g:lightline = {
		\	'colorscheme': 'wombat',
		\	'active': {
		\		'left': [ [ 'mode', 'paste' ],
		\				[ 'gitbranch' ],
		\				[ 'readonly', 'filetype', 'filename' ]],
		\		'right': [ [ 'percent' ], [ 'lineinfo' ],
		\				[ 'fileformat', 'fileencoding' ],
		\				[ 'linter_errors', 'linter_warnings' ]]
		\	},
		\	'component_expand': {
		\		'linter': 'LightlineLinter',
		\		'linter_warnings': 'LightlineLinterWarnings',
		\		'linter_errors': 'LightlineLinterErrors',
		\		'linter_ok': 'LightlineLinterOk'
		\	},
		\	'component_type': {
		\		'readonly': 'error',
		\		'linter_warnings': 'warning',
		\		'linter_errors': 'error'
		\	},
		\	'component_function': {
		\		'fileencoding': 'LightlineFileEncoding',
		\		'filename': 'LightlineFileName',
		\		'fileformat': 'LightlineFileFormat',
		\		'filetype': 'LightlineFileType',
		\		'gitbranch': 'LightlineGitBranch'
		\	},
		\	'tabline': {
		\		'left': [ [ 'tabs' ] ],
		\		'right': [ [ 'close' ] ]
		\	},
		\	'tab': {
		\		'active': [ 'filename', 'modified' ],
		\		'inactive': [ 'filename', 'modified' ],
		\	},
		\	'separator': { 'left': '', 'right': '' },
		\	'subseparator': { 'left': '', 'right': '' }
		\ }

		function! LightlineFileName() abort
			let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
			if filename =~ 'NERD_tree'
				return ''
			endif
			let modified = &modified ? ' +' : ''
			return fnamemodify(filename, ":~:.") . modified
		endfunction

		function! LightlineFileEncoding()
			" only show the file encoding if it's not 'utf-8'
			return &fileencoding == 'utf-8' ? '' : &fileencoding
		endfunction

		function! LightlineFileFormat()
			" only show the file format if it's not 'unix'
			let format = &fileformat == 'unix' ? '' : &fileformat
			return winwidth(0) > 70 ? format . ' ' . WebDevIconsGetFileFormatSymbol() : ''
		endfunction

		function! LightlineFileType()
			return WebDevIconsGetFileTypeSymbol()
			" return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
		endfunction

		function! LightlineLinter() abort
			let l:counts = ale#statusline#Count(bufnr(''))
			return l:counts.total == 0 ? '' : printf('×%d', l:counts.total)
		endfunction

		function! LightlineLinterWarnings() abort
			let l:counts = ale#statusline#Count(bufnr(''))
			let l:all_errors = l:counts.error + l:counts.style_error
			let l:all_non_errors = l:counts.total - l:all_errors
			return l:counts.total == 0 ? '' : '⚠ ' . printf('%d', all_non_errors)
		endfunction

		function! LightlineLinterErrors() abort
			let l:counts = ale#statusline#Count(bufnr(''))
			let l:all_errors = l:counts.error + l:counts.style_error
			return l:counts.total == 0 ? '' : '✖ ' . printf('%d', all_errors)
		endfunction

		function! LightlineLinterOk() abort
			let l:counts = ale#statusline#Count(bufnr(''))
			return l:counts.total == 0 ? 'OK' : ''
		endfunction

		function! LightlineGitBranch()
			return "\uE725" . (exists('*fugitive#head') ? fugitive#head() : '')
		endfunction

		function! LightlineUpdate()
			if g:goyo_entered == 0
				" do not update lightline if in Goyo mode
				call lightline#update()
			endif
		endfunction

		augroup alestatus
			autocmd User ALELint call LightlineUpdate()
		augroup end
	" }}}
" }}}

" General Mappings {{{
	" set a map leader for more key combos
	let mapleader = ','

	" shortcut to save
	nmap <leader>, :w<cr>

	" set paste toggle
	set pastetoggle=<leader>v

	" edit ~/.config/nvim/init.vim
	map <leader>ev :e! ~/.config/nvim/init.vim<cr>

	" clear highlighted search
	noremap <space> :set hlsearch! hlsearch?<cr>

	" activate spell-checking alternatives
	nmap ;s :set invspell spelllang=en<cr>

	" remove extra whitespace
	nmap <leader><space> :%s/\s\+$<cr>
	nmap <leader><space><space> :%s/\n\{2,}/\r\r/g<cr>

	inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
	inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

	nmap <leader>l :set list!<cr>

	" Textmate style indentation
	vmap <leader>[ <gv
	vmap <leader>] >gv
	nmap <leader>[ <<
	nmap <leader>] >>

	" switch between current and last buffer
	nmap <leader>. <c-^>

	" enable . command in visual mode
	vnoremap . :normal .<cr>

	map <silent> <C-h> :call functions#WinMove('h')<cr>
	map <silent> <C-j> :call functions#WinMove('j')<cr>
	map <silent> <C-k> :call functions#WinMove('k')<cr>
	map <silent> <C-l> :call functions#WinMove('l')<cr>

	map <leader>wc :wincmd q<cr>

	" scroll the viewport faster
	nnoremap <C-e> 3<C-e>
	nnoremap <C-y> 3<C-y>

	" moving up and down work as you would expect
	nnoremap <silent> j gj
	nnoremap <silent> k gk
	nnoremap <silent> ^ g^
	nnoremap <silent> $ g$

	nnoremap <silent> <leader>u :call functions#HtmlUnEscape()<cr>

	command! Rm call functions#Delete()
	command! RM call functions#Delete() <Bar> q!
" }}}

" AutoGroups {{{
	" file type specific settings
	augroup configgroup
		autocmd!

		" automatically resize panes on resize
		autocmd VimResized * exe 'normal! \<c-w>='
		autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
		autocmd BufWritePost .vimrc.local source %
		" save all files on focus lost, ignoring warnings about untitled buffers
		autocmd FocusLost * silent! wa

		" make quickfix windows take all the lower section of the screen
		" when there are multiple windows open
		autocmd FileType qf wincmd J
		autocmd FileType qf nmap <buffer> q :q<cr>
	augroup END
" }}}

" General Functionality {{{
	" substitute, search, and abbreviate multiple variants of a word
	Plug 'tpope/vim-abolish'

	" search inside files using ripgrep. This plugin provides an Ack command.
	Plug 'wincent/ferret'

	" insert or delete brackets, parens, quotes in pair
	Plug 'jiangmiao/auto-pairs'

	" easy commenting motions
	Plug 'tpope/vim-commentary'

	" mappings which are simply short normal mode aliases for commonly used ex commands
	Plug 'tpope/vim-unimpaired'

	" mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
	Plug 'tpope/vim-surround'

	" enables repeating other supported plugins with the . command
	Plug 'tpope/vim-repeat'

	" asynchronous build and test dispatcher
	Plug 'tpope/vim-dispatch'

	" single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
	Plug 'AndrewRadev/splitjoin.vim'

	" extended % matching
	Plug 'vim-scripts/matchit.zip'

	" add end, endif, etc. automatically
	Plug 'tpope/vim-endwise'

	" a simple tool for presenting slides in vim based on text files
	Plug 'sotte/presenting.vim', { 'for': 'markdown' }

	" Close buffers but keep splits
	Plug 'moll/vim-bbye'
	nmap <leader>b :Bdelete<cr>

	" Writing in vim {{{{
		Plug 'junegunn/limelight.vim'
		Plug 'junegunn/goyo.vim'
		let g:limelight_conceal_ctermfg = 240

        let g:goyo_entered = 0
		function! s:goyo_enter()
			silent !tmux set status off
            let g:goyo_entered = 1
			set noshowmode
			set noshowcmd
			set scrolloff=999
			Limelight
		endfunction

		function! s:goyo_leave()
			silent !tmux set status on
            let g:goyo_entered = 0
			set showmode
			set showcmd
			set scrolloff=5
			Limelight!
		endfunction

		autocmd! User GoyoEnter nested call <SID>goyo_enter()
		autocmd! User GoyoLeave nested call <SID>goyo_leave()
	" }}}

	" context-aware pasting
	Plug 'sickill/vim-pasta'

	" NERDTree {{{
		Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
		Plug 'Xuyuanp/nerdtree-git-plugin'
		Plug 'ryanoasis/vim-devicons'

		" Toggle NERDTree
		function! ToggleNerdTree()
			if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
				:NERDTreeFind
			else
				:NERDTreeToggle
			endif
		endfunction
		" toggle nerd tree
		nmap <silent> <leader>k :call ToggleNerdTree()<cr>
		" find the current file in nerdtree without needing to reload the drawer
		nmap <silent> <leader>y :NERDTreeFind<cr>

		let NERDTreeShowHidden=1
		let NERDTreeDirArrowExpandable = '▷'
		let NERDTreeDirArrowCollapsible = '▼'
		let g:NERDTreeIndicatorMapCustom = {
		\ "Modified"  : "✹",
		\ "Staged"	  : "✚",
		\ "Untracked" : "✭",
		\ "Renamed"   : "➜",
		\ "Unmerged"  : "═",
		\ "Deleted"   : "✖",
		\ "Dirty"	  : "✗",
		\ "Clean"	  : "✔︎",
		\ 'Ignored'   : '☒',
		\ "Unknown"   : "?"
		\ }
	" }}}

	" FZF {{{
		Plug '/usr/local/opt/fzf'
		Plug 'junegunn/fzf.vim'
		let g:fzf_layout = { 'down': '~25%' }

		nmap <silent> <leader>s :GFiles?<cr>

		nmap <silent> <leader>r :Buffers<cr>
		nmap <silent> <leader>e :FZF<cr>
		nmap <leader><tab> <plug>(fzf-maps-n)
		xmap <leader><tab> <plug>(fzf-maps-x)
		omap <leader><tab> <plug>(fzf-maps-o)

		" Insert mode completion
		imap <c-x><c-k> <plug>(fzf-complete-word)
		imap <c-x><c-f> <plug>(fzf-complete-path)
		imap <c-x><c-j> <plug>(fzf-complete-file-ag)
		imap <c-x><c-l> <plug>(fzf-complete-line)

		nnoremap <silent> <Leader>C :call fzf#run({
		\	'source':
		\	  map(split(globpath(&rtp, "colors/*.vim"), "\n"),
		\		  "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
		\	'sink':    'colo',
		\	'options': '+m',
		\	'left':    30
		\ })<CR>

		command! FZFMru call fzf#run({
		\  'source':  v:oldfiles,
		\  'sink':	  'e',
		\  'options': '-m -x +s',
		\  'down':	  '40%'})

		command! -bang -nargs=* Find call fzf#vim#grep(
			\ 'rg --column --line-number --no-heading --follow --color=always '.<q-args>, 1,
			\ <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
		command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
		command! -bang -nargs=? -complete=dir GitFiles
			\ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%', '?'), <bang>0)
	" }}}

	" vim-fugitive {{{
		Plug 'tpope/vim-fugitive'
		Plug 'tpope/vim-rhubarb' " hub extension for fugitive
        Plug 'junegunn/gv.vim'
        Plug 'sodapopcan/vim-twiggy'
        Plug 'christoomey/vim-conflicted'
		nmap <silent> <leader>gs :Gstatus<cr>
		nmap <leader>ge :Gedit<cr>
		nmap <silent><leader>gr :Gread<cr>
		nmap <silent><leader>gb :Gblame<cr>
	" }}}

	" ALE {{{
		Plug 'w0rp/ale' " Asynchonous linting engine
		let g:ale_change_sign_column_color = 0
		let g:ale_sign_column_always = 1
		let g:ale_sign_error = '✖'
		let g:ale_sign_warning = '⚠'

		let g:ale_linters = {
		\	'javascript': ['eslint'],
		\	'typescript': ['tsserver', 'tslint'],
		\}
		let g:ale_fixers = {}
		let g:ale_fixers['javascript'] = ['prettier']
        let g:ale_fixers['typescript'] = ['prettier', 'tslint']
		let g:ale_fixers['json'] = ['prettier']
		let g:ale_javascript_prettier_use_local_config = 1
		let g:ale_fix_on_save = 0
	" }}}

	" UltiSnips {{{
		Plug 'SirVer/ultisnips' " Snippets plugin
		let g:UltiSnipsExpandTrigger="<tab>"
	" }}}
" }}}

" Language-Specific Configuration {{{
	" JavaScript {{{
		Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
		Plug 'moll/vim-node', { 'for': 'javascript' }
		Plug 'mxw/vim-jsx', { 'for': ['javascript.jsx', 'javascript'] }
		Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }
	" }}}

	" TypeScript {{{
		Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
		Plug 'Shougo/vimproc.vim', { 'do': 'make' }

        Plug 'Quramy/tsuquyomi', { 'for': 'typescript', 'do': 'npm install' }
		let g:tsuquyomi_completion_detail = 1
		let g:tsuquyomi_disable_default_mappings = 1
		let g:tsuquyomi_completion_detail = 1
	" }}}


	" Styles {{{
		Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
	" }}}

	" markdown {{{
		Plug 'tpope/vim-markdown', { 'for': 'markdown' }

		" Open markdown files in Marked.app - mapped to <leader>m
		Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' }
		nmap <leader>m :MarkedOpen!<cr>
		nmap <leader>mq :MarkedQuit<cr>
		nmap <leader>* *<c-o>:%s///gn<cr>
	" }}}

	" JSON {{{
		Plug 'elzr/vim-json', { 'for': 'json' }
		let g:vim_json_syntax_conceal = 0
	" }}}

	Plug 'fatih/vim-go', { 'for': 'go' }
" }}}

	Plug 'arcticicestudio/nord-vim'
call plug#end()

" Colorscheme and final setup {{{
	set background=dark
	colorscheme nord
	let g:enable_italic_font = 1
	let g:enable_bold_font = 1
	syntax on
	filetype plugin indent on
	" make the highlighting of tabs and other non-text less annoying
	highlight SpecialKey ctermfg=236
	highlight NonText ctermfg=236

	" make comments and HTML attributes italic
	highlight Comment cterm=italic
	highlight Type cterm=italic
	highlight Normal ctermbg=none

	inoremap jj <Esc>
	nnoremap qq :nohl<CR>
	noremap <C-J> }
	noremap <C-K> {
	noremap ff :FZF <CR>

"	if !empty($EPITECH_PATH) && getcwd() =~ $EPITECH_PATH
"		set sts=0 sw=8 ts=8
"	endif
" }}}
