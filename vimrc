set nocompatible " Forget about Vi compatibility

"" This configuration uses vim-pulg to manage plugins
call plug#begin('~/.vim/bundle/')

Plug 'bling/vim-airline'
Plug 'ajh17/VimCompletesMe'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'lervag/vimtex'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}

"" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'

call plug#end()

runtime macros/matchit.vim

"" Indentation
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd FileType tex setlocal shiftwidth=2 softtabstop=2

"" General appearance
set number
set laststatus=2 " Always show vim-airline
set noshowmode   " Avoid redundance with vim-airline
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

"" Julia
let g:default_julia_version = '1.3'

" language server
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
\   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       using Pkg;
\       import StaticLint;
\       import SymbolServer;
\       env_path = dirname(Pkg.Types.Context().env.project_file);
\       debug = false;
\
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "");
\       server.runlinter = true;
\       run(server);
\   ']
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
