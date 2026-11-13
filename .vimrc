set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()

Plug 'bogado/file-line'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'richq/vim-cmake-completion'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'aklt/plantuml-syntax'

if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'stevearc/oil.nvim'
else
    Plug 'scrooloose/nerdtree'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete-file.vim'
    Plug 'ervandew/supertab'
endif

call plug#end()

" Common
set t_Co=256
set bg=dark
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_italic=0
colorscheme gruvbox
if has('nvim')
    lua vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Pmenu' })
    lua vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Pmenu' })
endif
syntax on

set backspace=indent,eol,start
set number relativenumber
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
set mouse=a
set enc=utf-8
set fenc=utf-8
if !has('nvim')
    set termencoding=utf-8
endif
set smartindent
set textwidth=100
set showmatch
set comments=sl:/*,mb:\ *,elx:\ */
set autoread
set autowrite
set termguicolors
set updatetime=250

if has("gui_running")
    set guifont=Terminus:h14:cANSI
endif

if !has('nvim')
    if has("mouse_sgr")
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    end
endif

map <C-j> :cn<CR>
map <C-k> :cp<CR>

if !has('nvim')
    inoremap <C-Space> <C-x><C-o>
endif

let &colorcolumn="100,".join(range(120,999),",")
highlight ColorColumn guibg=gray25 ctermbg=236

au BufRead,BufNewFile *.do              set filetype=tcl
au BufRead,BufNewFile *.v,*.vh          set filetype=verilog
au FileType qf                          setlocal nospell nonumber colorcolumn=0

let g:zipPlugin_ext= '*.zip,*.jar,*.aar,*.apk'

" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Underline misspelled words
highlight clear SpellBad
highlight SpellBad cterm=underline

nmap <Leader>s :set spell!<CR>
nmap <Leader>w :set wrap!<CR>
nmap <Leader>h :set cursorline!<CR>
nmap <Leader>r :set readonly!<CR>
nmap <Leader>cn :cnext<CR>
nmap <Leader>cp :cprevious<CR>
nmap <Leader>ln :lnext<CR>
nmap <Leader>lp :lprevious<CR>
" Plugin-specific settings

" NERDTree
nmap <Leader>nt :NERDTreeToggle<CR>
nmap <Leader>nl :NERDTreeFind<CR>

" FZF
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>fp :Files ..<CR>
nmap <Leader>fpp :Files ../..<CR>

if !has('nvim')
    " SuperTab
    let g:SuperTabDefaultCompletionType = 'context'
endif

" LSP
if !has('nvim')
    let g:lsp_use_native_client = 1
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_diagnostics_float_cursor = 1
    let g:lsp_diagnostics_virtual_text_enabled = 0
    let g:lsp_semantic_enabled = 1
    let g:lsp_semantic_delay = 100
    let g:lsp_settings = {
    \    "gopls" : {
    \        "semantic_highlight": v:true
    \     }
    \}

    function! s:on_lsp_buffer_enabled() abort
        " nmap <buffer>  <plug>(lsp-declaration)
        " nmap <buffer>  <plug>(lsp-peek-declaration)

        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> sd <plug>(lsp-peek-definition)
        nmap <buffer> gt <plug>(lsp-type-definition)
        nmap <buffer> st <plug>(lsp-peek-type-definition)

        nmap <buffer> gi <plug>(lsp-implementation)
        " nmap <buffer>  <plug>(lsp-peek-implementation)

        " nmap <buffer>  <plug>(lsp-document-diagnostics)
        nmap <buffer> ]g <plug>(lsp-next-diagnostic)
        " nmap <buffer>  <plug>(lsp-next-diagnostic-nowrap)
        " nmap <buffer>  <plug>(lsp-next-error)
        " nmap <buffer>  <plug>(lsp-next-error-nowrap)
        " nmap <buffer>  <plug>(lsp-next-reference)
        " nmap <buffer>  <plug>(lsp-next-warning)
        " nmap <buffer>  <plug>(lsp-next-warning-nowrap)
        nmap <buffer> [g <plug>(lsp-previous-diagnostic)
        " nmap <buffer>  <plug>(lsp-previous-diagnostic-nowrap)
        " nmap <buffer>  <plug>(lsp-previous-error)
        " nmap <buffer>  <plug>(lsp-previous-error-nowrap)
        " nmap <buffer>  <plug>(lsp-previous-reference)
        " nmap <buffer>  <plug>(lsp-previous-warning)
        " nmap <buffer>  <plug>(lsp-previous-warning-nowrap)

        nmap <buffer> K <plug>(lsp-hover)
        " nmap <buffer>  <plug>(lsp-hover-float)
        " nmap <buffer>  <plug>(lsp-hover-preview)

        " nmap <buffer>  <plug>(lsp-code-action)
        nmap <buffer> <Leader>a <plug>(lsp-code-action-float)
        " nmap <buffer>  <plug>(lsp-code-action-preview)
        " nmap <buffer>  <plug>(lsp-code-lens)

        " nmap <buffer>  <plug>(lsp-call-hierarchy-incoming)
        " nmap <buffer>  <plug>(lsp-call-hierarchy-outgoing)
        " nmap <buffer>  <plug>(lsp-type-hierarchy)

        " nmap <buffer>  <plug>(lsp-document-symbol)
        nmap <buffer> gs <plug>(lsp-document-symbol-search)
        " nmap <buffer>  <plug>(lsp-workspace-symbol)
        nmap <buffer> gS <plug>(lsp-workspace-symbol-search)

        nmap <buffer> <leader>rn <plug>(lsp-rename)

        nmap <buffer> gr <plug>(lsp-references)

        " nmap <buffer>  <plug>(lsp-document-format)
        " nmap <buffer>  <plug>(lsp-document-format)
        " nmap <buffer>  <plug>(lsp-document-range-format)
        " nmap <buffer>  <plug>(lsp-document-range-format)

        " nmap <buffer>  <plug>(lsp-preview-close)
        " nmap <buffer>  <plug>(lsp-preview-focus)
        " nmap <buffer>  <plug>(lsp-status)
        " nmap <buffer>  <plug>(lsp-signature-help)
    endfunction

    augroup lsp_install
        au!
        autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    augroup END

    " asyncomplete and sources
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
        \ 'name': 'file',
        \ 'allowlist': ['*'],
        \ 'priority': 10,
        \ 'completor': function('asyncomplete#sources#file#completor')
        \ }))
else
    lua require('completion')
    lua require('lsp')
    lua require('my-oil')
endif
