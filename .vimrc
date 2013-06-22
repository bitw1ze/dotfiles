set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github

" snipmate dependencies
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
Bundle 'garbas/vim-snipmate'

Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdtree'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'vim-scripts/OmniCppComplete'
Bundle 'vim-scripts/taglist.vim'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
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
set mouse=v             
if &t_Co > 2 || has("gui_running")
  syntax on          
  set nohlsearch       
  set incsearch      
endif
map <F10> :noh<CR>
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
map <F3> :w<CR> :make view<CR>
map <F4> :NERDTreeToggle<CR>
map ** gwap #line wrap
map <F5> :set paste!<CR>
map <F6> :set paste<CR>i<CR>%---<CR>\pagebreak<CR>\vtitle{}<CR>\vid{}<CR>\vclass{}<CR>\vseverity{}<CR>\vdifficulty{}<CR>\vuln<CR><CR>\vtargets<CR><CR>\vdesc<CR><CR>\vscenario<CR><CR>\vshortterm<CR><CR>\vlongterm<CR><C-c>:set nopaste<CR>

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

colorscheme desert
set cursorline
:hi CursorLine   cterm=NONE ctermbg=darkgray guibg=darkgray guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkgray guibg=darkgray guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
