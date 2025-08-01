set nocompatible " Forget about Vi compatibility

"" This configuration uses vim-pulg to manage plugins
call plug#begin('~/.vim/bundle/')

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'edkolev/tmuxline.vim', { 'on': [] }
Plug 'JuliaEditorSupport/julia-vim'
Plug 'junegunn/vim-easy-align'
Plug 'lervag/vimtex'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'voldikss/vim-floaterm'
Plug 'https://git.sr.ht/~ackyshake/VimCompletesMe.vim'

"" Colorschemes
Plug 'NLKNguyen/papercolor-theme'
Plug 'sainnhe/sonokai'
Plug 'vim-airline/vim-airline-themes'

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
set signcolumn=yes
set splitbelow
set splitright
set textwidth=90
set ttimeoutlen=50
set completeopt+=longest
let &colorcolumn = '93'
autocmd FileType tex setlocal textwidth=72

"" Fonts & colors
syntax on

if has('gui_running')
    set background=light
    set linespace=2
    set guioptions-=T
    set guioptions-=r
    colorscheme PaperColor
else
    set background=dark
    if has('termguicolors') && ("alacritty\|.*256.*\|.*true.*" =~ &term)
        set termguicolors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        colorscheme sonokai
    else
        set t_Co=16
        let &t_AF = "\<Esc>[38;5;%dm"
        let &t_AB = "\<Esc>[48;5;%dm"
        let g:airline_theme = 'sonokai'
        call airline#parts#define_accent('mode', 'none')
        call airline#parts#define_accent('linenr', 'none')
        call airline#parts#define_accent('maxlinenr', 'none')
        call airline#parts#define_accent('colnr', 'none')
        colorscheme unokai
    endif
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
let g:airline_extended_edges = g:airline_powerline_fonts && &termguicolors
let g:airline_symbol_left_edge = ''
let g:airline_symbol_right_edge = ''
let g:airline_theme_patch_func = 'AirlineThemePatch'

function! AirlineThemePatch(palette)
    for m in keys(a:palette)
        let mode = a:palette[m]
        for g in keys(mode)
            if match(g, escape('_edge', '\') . '$') == -1
                let mode[g . '_edge'] = [mode[g][1], '', mode[g][3], '']
            endif
        endfor
    endfor
endfunction

function! AirlineExtendedEdges(activity, builder, context)
    let funcrefs = get(g:, 'airline_' . a:activity . '_funcrefs', [])[1:] +
        \ [
        \      function('airline#extensions#apply'),
        \      function('airline#extensions#default#apply')
        \ ]

    call airline#util#exec_funcrefs(funcrefs, a:builder, a:context)

    if !get(g:, 'airline_extended_edges', 0)
        return 1
    endif

    let ls = get(g:, 'airline_symbol_left_edge', '')
    let rs = get(g:, 'airline_symbol_right_edge', '')

    if a:builder.get_position() == 0
        let line = '%#airline_c_edge#' . ls . '%#airline_c#%=%#airline_c_edge#' . rs
        call a:builder.add_raw(line)
    else
        let left_group = substitute(a:builder._sections[0][0], '\d\+', '', '')
        let right_group = substitute(a:builder._sections[-1][0], '\d\+', '', '')
        let sections = [['', '%#' . left_group . '_edge#' . ls]]
        let sections += a:builder._sections
        let sections += [['', '%#' . right_group . '_edge#' . rs]]
        let a:builder._sections = sections
    endif

    return 1
endfunction

call airline#add_statusline_funcref(function('AirlineExtendedEdges', ['statusline']))
call airline#add_inactive_statusline_funcref(function('AirlineExtendedEdges', ['inactive']))

"  vim-floaterm
let g:floaterm_autoclose = 1
let g:floaterm_opener = 'tabe'

"  Language Server Protocol
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = [ '~/.vim/settings.json', '.vim/settings.json' ]
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
\   'python': ['pylsp'],
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
tnoremap kj <C-\><C-n>
tnoremap <silent> <Leader>ftn <C-\><C-n>:FloatermNext<CR>
tnoremap <silent> <Leader>fth <C-\><C-n>:FloatermHide<CR>
vnoremap <silent> <Leader><CR> :'<,'>FloatermSend<CR><CR>
" LSP
nnoremap <silent> <Leader>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <Leader>lf :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2>       :call LanguageClient_textDocument_rename()<CR>
