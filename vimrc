filetype off
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'

Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'jcf/vim-latex'
Bundle 'wlangstroth/vim-haskell'
Bundle 'tpope/vim-ragtag'
Bundle 'jceb/vim-orgmode'
Bundle 'utl.vim'
Bundle 'calendar.vim--Matsumoto'
Bundle 'chrisbra/NrrwRgn'
Bundle 'tpope/vim-eunuch'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdcommenter'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-speeddating'
Bundle 'scrooloose/syntastic'
Bundle 'rodjek/vim-puppet'
Bundle 'tpope/vim-markdown'
"Bundle 'klen/python-mode'
"Bundle 'Conque-Shell'
Bundle 'vim-ruby/vim-ruby'
Bundle 'fatih/vim-go'
Bundle 'terryma/vim-multiple-cursors'
"Bundle 'airblade/vim-gitgutter'
Bundle 'Valloric/YouCompleteMe'
Bundle 'mileszs/ack.vim'
Bundle 'wting/rust.vim'
Bundle 'elixir-lang/vim-elixir'
Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'suan/vim-instant-markdown'
Plugin 'SirVer/ultisnips'
Plugin 'solarnz/thrift.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()

nmap <leader>tg :TagbarToggle<CR>

syntax on
set ruler
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
"Custom options:
set nobackup		" Don't keep a backup file
set nosol		" Cursor kept in same column (if possible)
set ttyfast		" Smoother changes
set number		" Line numbers
filetype on
filetype indent on
filetype plugin on
set shiftwidth=2
set tabstop=2		" Number of spaces to autoindent
set expandtab		" Converts tab to spaces
set softtabstop=2
set autoindent
set backspace=indent,eol,start " Smart backspacing
autocmd BufWritePre * :%s/\s\+$//e
" Mouse highlight quick copy
vmap <C-C> "+y

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

set background=dark

if has("gui_running")
    colorscheme solarized
    "colorscheme ir_black
    set guioptions=egmrt
else
    let g:solarized_termtrans=1
    colorscheme solarized
endif


if has("gui_running")
    if has("gui_gtk2")
        set guifont=Fira\ Mono\ 14
    else
        set guifont=Fira\ Mono:h14
    endif
    " Disable terminal bells
    set vb t_vb=
endif

"""""""""
" Plugins
"""""""""
" VimOrganizer
let g:ft_ignore_pat = '\.org'
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufEnter *.org            call org#SetOrgFileType()
let g:org_command_for_emacsclient='emacsclient -a'
let g:org_agenda_select_dirs=['~/Tasks']
let g:org_agenda_files=['~/Tasks/tasks.org']
let g:org_capture_file ='~/Tasks/captures.org'
command! OrgCapture :call org#CaptureBuffer()
command! OrgCaptureFile :call org#OpenCaptureFile()
let g:org_todo_setup='TODO STARTED | DONE CANCELLED'
nnoremap <Leader>cb :call org#OpenCaptureFile()

" Tagbar
nmap <leader>tg :TagbarToggle<CR>
let g:tagbar_type_puppet = {
   \ 'ctagstype': 'puppet',
   \ 'kinds': [
   \ 'c:class',
   \ 's:site',
   \ 'n:node',
   \ 'd:definition'
   \]
\}
let g:tagbar_type_markdown = {
	\ 'ctagstype' : 'markdown',
	\ 'kinds' : [
		\ 'h:Heading_L1',
		\ 'i:Heading_L2',
		\ 'k:Heading_L3'
	\ ]
\ }

" Ruby stuff
"autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
"autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
"autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd Filetype ruby,eruby,python setlocal tabstop=2 shiftwidth=2 softtabstop=2

" PHP
autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Python
"autocmd FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
" Haskell
autocmd FileType haskell setlocal tabstop=8

" Puppet
"autocmd BufRead,BufNew let g:loaded_syntastic_puppet_puppetlint_checker = 1
autocmd BufRead,BufNew *.eyaml set filetype=yaml

" Javascript
let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

" LaTeX
let g:Tex_CompileRule_pdf='pdflatex --shell-escape -synctex=1 --interaction=nonstopmode $*'
let g:Tex_MultipleCompileFormats='pdf,aux,dvi,ps'
let g:Tex_DefaultTargetFormat='pdf'

" Fugitive
command GSquashLast2 Git rebase -i HEAD~2

" Python Mode
"let g:mode_lint_checker = "pylint"
"let g:pymode_lint_ignore = "W0311,E501,E503,E111"
"let g:pymode_lint_config = "~/.pylintrc"
let g:pymode_lint = 0

" ctrl-p
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
