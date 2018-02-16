set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

" My Plugins here:
"
" original repos on github

Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-rails.git'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'vim-scripts/taglist.vim'
"Plugin  'bling/vim-airline'
Plugin 'michalbachowski/vim-wombat256mod'
" snipmate dependencies
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
" Plugin 'honza/vim-snippets'
" Plugin 'garbas/vim-snipmate'
Plugin 'rust-lang/rust.vim'

" vim-scripts repos
Plugin 'L9'
Plugin 'FuzzyFinder'

" non github repos
Plugin 'git://git.wincent.com/command-t.git'
" ...

" swift
Plugin 'kballard/vim-swift'

Plugin 'altercation/vim-colors-solarized'
Plugin 'junegunn/goyo.vim'
Plugin 'itchyny/lightline.vim'

Plugin 'tpope/vim-markdown'
Plugin 'vim-scripts/SyntaxRange'

" fzf plugin
set rtp+=/usr/local/opt/fzf
Plugin 'junegunn/fzf.vim'

Plugin 'leafgarland/typescript-vim'

" haskell plugin settings
"au BufEnter *.hs compiler ghc
"let g:haddock_browser="/usr/bin/chromium-browser"
"let g:haddock_docdir="/usr/share/haddock-2.11.0/html/"

call vundle#end() " required
filetype plugin indent on     " required!
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
set nocompatible      

set background=dark     
set wrap              
set scrolloff=2         
set nonumber              
set showmode            
set showcmd             
set ruler               
set title               
set wildmenu            

set esckeys             
set ignorecase          
set smartcase           
set smartindent         
set smarttab            
set magic               
set bs=indent,eol,start 
set nobackup            

set tabstop=4
set shiftwidth=4
set expandtab
set fileformat=unix     

set viminfo='20,\"500   
set hidden              
set history=50          
set mouse=a
if &t_Co > 2 || has("gui_running")
  syntax on          
  set nohlsearch       
  set incsearch      
endif
map <Space> :noh<CR>
"let g:LatexBox_quickfix           =0
set pastetoggle=<F11>
if has("autocmd")
  let bash_is_sh=1
  autocmd BufEnter * lcd %:p:h

  
"  augroup vdboor
"    au BufReadPre,BufNewFile
"    \ *.xsl,*.xml,*.css,*.html,*.js,*.php,*.sql,*.sh,*.conf,*.cc,*.cpp,*.h
"    \  set smartindent shiftwidth=2 softtabstop=2 expandtab
"
"    au BufReadPre,BufNewFile
"    \ *.tex
"    \ set wrap shiftwidth=2 softtabstop=2 expandtab
"  augroup END

  augroup perl
    " reset (disable previous 'augroup perl' settings)
    au!  

    au BufReadPre,BufNewFile
    \ *.pl,*.pm
    \ set formatoptions=croq smartindent shiftwidth=2 softtabstop=2 cindent cinkeys='0{,0},!^F,o,O,e' " tags=./tags,tags,~/devel/tags,~/devel/C
  augroup END
  autocmd BufReadPost * 
    \ if line("'\"") > 0 && line("'\"") <= line("$") | 
    \   exe "normal g`\"" | 
    \ endif 

  augroup latex
      set tabstop=2 shiftwidth=2

  augroup python
      set tabstop=4 shiftwidth=4

:au BufRead *.jad set syntax=java

endif 

if bufwinnr(1)
	map + <C-W>+
	map - <C-W>-
endif

" stuff for latex plugin to work
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor="latex"


map <F8> :w<CR> :make<CR>
map <F2> :set number!<CR> :set foldcolumn=0<CR>
map <F3> :set rnu!<CR>
"map <F3> :w<CR> :make view<CR>
map <F4> :NERDTreeToggle<CR>
map ** gwap #line wrap
map <F5> :set paste!<CR>

filetype plugin indent on
set autoindent
set nonu
set ic
set hls
set lbr

map <silent> <F9> :NERDTreeToggle<CR>
nnoremap map <silent> <F9> :NERDTreeToggle<CR>
map <silent> <F8> :TlistToggle<CR>
nnoremap map <silent> <F8> :TlistToggle<CR>

set tags=.tags;

nmap j gj
nmap k gk

colorscheme wombat256mod
syntax enable
"set background=dark
"colorscheme solarized

set cursorline
":hi CursorLine   cterm=NONE ctermbg=white guibg=darkgray guifg=white
:hi CursorColumn cterm=NONE ctermbg=white  guibg=darkgray guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Set easymotion's leader key back to default leader
let g:EasyMotion_leader_key = '<Leader>'

" fix clipboard copy/paste with tmux
set clipboard=unnamed

:let @+ = expand("%:p")
" copy current file name (relative/absolute) to system clipboard
if has("mac") || has("gui_macvim") || has("gui_mac")
  " relative path  (src/foo.txt)
  nnoremap <leader>cf :let @*=expand("%")<CR>

  " absolute path  (/something/src/foo.txt)
  nnoremap <leader>cF :let @*=expand("%:p")<CR>

  " filename       (foo.txt)
  nnoremap <leader>ct :let @*=expand("%:t")<CR>

  " directory name (/something/src)
  nnoremap <leader>ch :let @*=expand("%:p:h")<CR>
endif

" copy current file name (relative/absolute) to system clipboard (Linux version)
if has("gui_gtk") || has("gui_gtk2") || has("gui_gnome") || has("unix")
  " relative path (src/foo.txt)
  nnoremap <leader>cf :let @+=expand("%")<CR>

  " absolute path (/something/src/foo.txt)
  nnoremap <leader>cF :let @+=expand("%:p")<CR>

  " filename (foo.txt)
  nnoremap <leader>ct :let @+=expand("%:t")<CR>

  " directory name (/something/src)
  nnoremap <leader>ch :let @+=expand("%:p:h")<CR>
endif

" fzf bindings
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

nmap \r :!tmux send-keys -t 0:0.1 C-p C-j <CR><CR>

function! ProseMode()
  call goyo#execute(0, [])
  set spell nolist noshowmode noshowcmd
  set complete+=s
  set bg=light
  if !has('gui_running')
    let g:solarized_termcolors=256
  endif
  colors solarized
endfunction

command! ProseMode call ProseMode()
nmap \p :ProseMode<CR>

