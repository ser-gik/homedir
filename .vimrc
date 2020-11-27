
" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'matchit.zip'
" Plugin 'vim-syntastic/syntastic'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Common
colorscheme evening
syntax on

set backspace=indent,eol,start
set number
set ruler
set hlsearch
set incsearch
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set cindent
set autoindent
set ffs=unix,dos
set spell

if has("gui_running")
    set guifont=Terminus:h14:cANSI
endif

let &colorcolumn="100,".join(range(120,999),",")
highlight ColorColumn guibg=gray25

au BufRead,BufNewFile *.do              set filetype=tcl
au BufRead,BufNewFile *.v,*.vh          set filetype=verilog
au FileType qf                          setlocal nospell nonumber colorcolumn=0

" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Plugin-specific settings

" NERDTree
nmap \nt :NERDTreeToggle<CR>
nmap \nl :NERDTreeFind<CR>


" SuperTab
let g:SuperTabDefaultCompletionType = 'context'


" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" 
" let g:syntastic_mode_map = {
"     \ "mode": "active",
"     \ "active_filetypes": ["verilog"],
"     \ "passive_filetypes": [] }
" 
" let g:syntastic_verilog_checkers = ["iverilog"]  " Requires Icarus Verilog 
