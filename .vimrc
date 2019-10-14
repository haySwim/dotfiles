" Vundle Stuff
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" Plugin 'jeaye/color_coded' Doesn't work with neovim >:(
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bash-support.vim'
Plugin 'bling/vim-airline'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'guicolorscheme.vim'
Plugin 'guns/vim-clojure-highlight'
Plugin 'guns/vim-clojure-static'
Plugin 'honza/vim-snippets'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'luochen1990/rainbow'
Plugin 'marijnh/tern_for_vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'nvie/vim-flake8'
Plugin 'panozzaj/vim-autocorrect'
Plugin 'rdnetto/YCM-Generator'
Plugin 'rhysd/devdocs.vim'
Plugin 'rhysd/vim-clang-format'
Plugin 'rstacruz/sparkup'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sheerun/vim-polyglot'
Plugin 'stephpy/vim-yaml'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-salve'
Plugin 'tpope/vim-surround'
Plugin 'venantius/vim-cljfmt'
Plugin 'venantius/vim-eastwood'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/paredit.vim'
Plugin 'vim-scripts/spec.vim'
Plugin 'junegunn/fzf.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" Use enter as expand trigger
"
" UltiSnips disables the use of whatever key expands so disable that unless
" there's a window open, but this makes hittng enter do nothing when the window
" is open, but nothing is selected, so work around that too.

let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
	let snippet = UltiSnips#ExpandSnippetOrJump()
	if g:ulti_expand_or_jump_res > 0
		return snippet
	else
		return "\<CR>"
	endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Space leader!!
let mapleader = "\<Space>"

" Numbers on by default
set number

" K opens devdocs
nmap K <Plug>(devdocs-under-cursor)

" Toggle relative numbers with <leader>j
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <leader>j :call NumberToggle()<cr>

" Open and close the quick window
nnoremap <leader>[ :copen<cr>
nnoremap <leader>] :cclose<cr>

" Navigate buffers with h and l
nnoremap <leader>h :bp<cr>
nnoremap <leader>l :bn<cr>

" Use ;; to enter normal mode.
inoremap ;; <ESC>

" Use ;;; to ;;.
inoremap ;;;  ;;

" YCM commands
" Try to goto something interesting
nnoremap <leader>g :YcmCompleter GoTo<cr>
" Get the type of whatever's under the cursor
nnoremap <leader>i :YcmCompleter GetType<cr>
" Seed language keywords.
"let g:ycm_seed_identifiers_with_syntax=1
" Auto close preview buffer.
let g:ycm_autoclose_preview_window_after_insertion=1
" Stop asking about the extra conf.
let g:ycm_confirm_extra_conf = 0

" Use Absolute numbers in insert mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Enable syntax highlighting
 syntax enable

" makes the colors all pretty
set background=dark
" IMPORTANT: Uncomment one of the following lines to force
" using 256 colors (or 88 colors) if your terminal supports it,
" but does not automatically use 256 colors by default.
set t_Co=256
" set t_Co=88
try
  if (&t_Co == 256 || &t_Co == 88) && !has('gui_running') &&
        \ filereadable(expand("$HOME/.vim/plugin/guicolorscheme.vim"))
    " Use the guicolorscheme plugin to makes 256-color or 88-color
    " terminal use GUI colors rather than cterm colors.
    runtime! plugin/guicolorscheme.vim
    GuiColorScheme solarized
  else
    " For 8-color 16-color terminals or for gvim, just use the
    " regular :colorscheme command.
    colorscheme solarized
  endif
catch /.*/ " Should probably not catch everything, but w/e.
  "failed to set colorscheme, continuing
endtry

" Rust Stuff
" rustfmt on autosave
let g:rustfmt_autosave = 1
" options for rust
let g:syntastic_rust_checkers=['rustc']

" Go Stuff
" vim-go extended syntax highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" Leader maps for go
au FileType go nmap <Leader>d <Plug>(go-doc)
au FileType go nmap <Leader>e <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <leader>a :GoAlternate<cr>
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>m <Plug>(go-metalinter)
" make vim-go only open quickfix windows
let g:go_list_type = "quickfix"
" use goimports for formatting
let g:go_fmt_command = "goimports"

" options for jslint
let g:syntastic_jslint_checkers=['jslint']
" options for rubocop
let g:syntastic_ruby_checkers=['rubocop']
" options for html
let g:syntastic_html_checkers=['validator']
" options for sass
let g:syntastic_sass_checkers=['sass']
" options for go
let g:syntastic_go_checkers = ['go', 'golint', 'govet']
let g:go_metalinter_command='golangci-lint run'
" options for python
let g:syntastic_python_checkers=['python', 'pylint', 'flake8']
let python_highlight_all=1
" options for clojure
let g:syntastic_clojure_checkers=['eastwood']


" general options for syntastic
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {}
let g:syntastic_aggregate_errors = 1

" C Stuff
"
" path to extra_conf for c family languages
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" help with that annoying -> syntax in C
inoremap ;/ ->
" autocompete automatically-er with C
let g:ycm_key_invoke_completion = '<leader>;'

" size of a hard tabstop
 set tabstop=2

" Pressing tab in insert mode will use 4 spaces
 set softtabstop=2

" always uses spaces instead of tab characters
 set expandtab

" size of an indent
 set shiftwidth=2

" Set Javascript tabs to 4 spaces
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

" Python specific stuff
" Set Python tabs to 4 spaces
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype python IndentGuidesEnable

" Yaml Stuff
autocmd Filetype yaml IndentGuidesEnable

" Treat .asm files as nasm
autocmd BufRead,BufNewFile *.asm set filetype=nasm

" Allows you to have multiple buffers open
 set hidden
" Lines of code will not wrap to the next line
 set nowrap
 " Make backspace behave like other editors
 set backspace=indent,eol,start
 " Automatically indent on new lines
 set autoindent
" Copy the indentation of the previous line if auto indent doesn't know what to do
 set copyindent
" Highlight matching braces/tags
 set showmatch
" Ignore case when searching
 set ignorecase
" ...unless there's a capital letter in the query
 set smartcase
" Indent to correct location with tab
 set smarttab
" Highlight search matches
 set hlsearch
" Search while you enter the query, not after
 set incsearch
" More undos
 set undolevels=1000
" Vim can set the title of the terminal window
 set title
" Use a visual indicator instead of a beep
 set visualbell
" Or just turn error bells off with this
 " set noerrorbells
" Toggle paste mode with F2
set pastetoggle=<F2>
" Use ; instead of : to enter commands, saves a lot of keystrokes in the long run
 nnoremap ; :
" Save all buffers on focus lost, ignore unnamed buffer warnings
:au FocusLost * silent! wa
" Set a color column
set colorcolumn=81

" Nerdtree stuff
" Start nerdtree when vim starts
"autocmd vimenter * NERDTree
" Use normal arrows
"let g:NERDTreeDirArrows=0
"<leader>n starts nerdtree
map <leader>n :NERDTreeToggle<CR>

" Statusline stuff
" Show the status line, even if there isn't a split
set laststatus=2

"RainbowParens stuff
" Activate all rainbows everywhere!
let g:rainbow_active = 1

" wrap long lines in quickfix
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END

" ctrlp stuff
" Show more results
" let g:ctrlp_match_window = 'results:100'
" Use leader for ctrlp
" let g:ctrlp_map = '<leader>p'
" ignore files that git ignores
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" fzf stuff.
"
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

" Open active buffers.
nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

" Open files in horizontal split
nnoremap <silent> <Leader>p :call fzf#run({
\   'down': '40%',
\   'source': 'git ls-files',
\   'options': '--tiebreak=length,end,begin',
\   'sink': 'botright split' })<CR>

" Load autocorrections on startup
autocmd VimEnter * call AutoCorrect()

" Clojure stuff.
" require-reload on save
autocmd BufWritePost Filetype clojure :Require<cr>
" omnifunc completion
let g:ycm_semantic_triggers = {'clojure' : ['.', '/', '(']}

" Mail stuff.
" Spell check
autocmd Filetype mail setlocal spell spelllang=en_us

" Undo for the next 90 days
set undofile
set undodir=~/.vim/undodir

let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')
