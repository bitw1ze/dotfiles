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

set tabstop=2           
set shiftwidth=2        



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
map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>
if has("autocmd")
  let bash_is_sh=1
  autocmd BufEnter * lcd %:p:h

  
  augroup vdboor
    au BufReadPre,BufNewFile
    \ *.xsl,*.xml,*.css,*.html,*.js,*.php,*.sql,*.sh,*.conf,*.cc,*.cpp,*.h
    \  set smartindent shiftwidth=2 softtabstop=2 expandtab

    au BufReadPre,BufNewFile
    \ *.tex
    \ set wrap shiftwidth=2 softtabstop=2 expandtab
  augroup END

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
map <F6> :set paste<CR>i<CR>%---<CR>\vtitle{}<CR>\vid{}<CR>\vclass{}<CR>\vseverity{}<CR>\vdifficulty{}<CR>\vuln<CR><CR>\vtargets<CR><CR>\vdesc<CR><CR>\vscenario<CR><CR>\vshortterm<CR><CR>\vlongterm<CR><CR>\pagebreak<CR><C-c>:set nopaste<CR>

syntax on
filetype indent on
set autoindent
set nu
set ic
set hls
set lbr

map <silent> <F9> :NERDTreeToggle<CR>
nnoremap map <silent> <F9> :NERDTreeToggle<CR>
map <silent> <F8> :TlistToggle<CR>
nnoremap map <silent> <F8> :TlistToggle<CR>

set expandtab
set ts=2

set tags=tags;
