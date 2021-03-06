set nocompatible " Forget about Vi compatibility

"" This configuration uses vim-pulg to manage plugins
call plug#begin('~/.vim/bundle/')

Plug 'ajh17/VimCompletesMe'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'bling/vim-airline'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'junegunn/vim-easy-align'
Plug 'lervag/vimtex'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'

"" Colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'gruvbox-community/gruvbox'

call plug#end()

runtime macros/matchit.vim

"" Indentation
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd FileType tex   setlocal shiftwidth=2 softtabstop=2

"" General appearance
set number
set laststatus=2 " Always show vim-airline
set noshowmode   " Avoid redundance with vim-airline
set signcolumn=yes
set splitbelow
set splitright
set textwidth=90
set ttimeoutlen=50
set completeopt+=longest
let &colorcolumn = join(range(93,120),",")

"" Fonts & colors
syntax on
if has('gui_running')
    set background=light
    set guioptions-=T
    colorscheme solarized
else
    if has('termguicolors')
        set termguicolors
    else
        set t_Co=256
    end
    set background=dark
    let g:gruvbox_italic = 1
    colorscheme gruvbox
endif

"" Searches
set incsearch
set hlsearch

"" In many terminal emulators the mouse works just fine
if has('mouse')
    set mouse=a
end

"" Plugins specific configurations
"  vim-airline
let g:airline_powerline_fonts = 1
let g:airline_exclude_filetypes = ['floaterm']

"  vim-floaterm
let g:floaterm_autoclose = 1
let g:floaterm_opener = 'tabe'

"  Language Server Protocol
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
\   'julia': ['julia', '--startup-file=no', '--history-file=no', '--project=.', '-e', '
\       using LanguageServer;
\       using Pkg;
\       import StaticLint;
\       import SymbolServer;
\       env_path = dirname(Pkg.Types.Context().env.project_file);
\
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, "");
\       server.runlinter = true;
\       run(server);
\   '],
\   'python': ['~/.julia/conda/3/bin/pyls'],
\ }

"" Custom shorcuts (key mappings)
let mapleader = ','
"  Select all
nmap <Leader>a ggVG
"  Save
nmap <Leader>s :update<CR>
"  Go to end of line
nmap ¿ $
"  Leave insert mode
inoremap kj <Esc>
"  Change to path od current file
nnoremap <Leader>cd :lcd %:p:h<CR>:pwd<CR>
" Floaterm
nnoremap <silent> <Leader>ftr
\   :FloatermNew --name=ftr --width=0.5 --wintype=vsplit --position=right<CR>
nnoremap <silent> <Leader>ftb
\   :FloatermNew --name=ftb --height=0.33 --wintype=split<CR>
nnoremap <silent> <Leader>ftn :FloatermNext<CR>
tnoremap <silent> <Leader>ftn <C-\><C-n>:FloatermNext<CR>
tnoremap <silent> <Leader>fth <C-\><C-n>:FloatermHide<CR>
tnoremap kj <C-\><C-n>
" LSP
nnoremap <silent> <Leader>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <Leader>lf :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2>       :call LanguageClient_textDocument_rename()<CR>
