set nocompatible " Forget about Vi compatibility

"" This configuration uses vim-pulg to manage plugins
call plug#begin('~/.vim/bundle/')

Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'edkolev/tmuxline.vim'
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
let &colorcolumn = join(range(93,120),",")
autocmd FileType tex setlocal textwidth=72

"" Fonts & colors
syntax on
if has('gui_running')
    set background=light
    set linespace=2
    set guioptions-=T
    colorscheme PaperColor
else
    if has('termguicolors')
        set termguicolors
    else
        set t_Co=256
    endif
    set background=dark
    if $TERM == 'linux'
        colorscheme unokai
    else
        colorscheme sonokai
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
if has('gui_running')
    let g:airline_theme = 'papercolor'
endif

" Leftmost powerline symbol - Alternative approach using autocmd
" This modifies the statusline after airline sets it, preserving all section content

function! s:get_powerline_symbol()
  " Get the powerline left separator symbol
  return get(g:airline_symbols, 'left_sep', '')
endfunction

function! s:get_mode_colors()
  " Get the current mode and determine highlight group name
  let mode = mode()
  if mode ==# 'i'
    return 'airline_a_insert'
  elseif mode =~# '\v[vV\<C-v>]'
    return 'airline_a_visual'
  elseif mode ==# 'R'
    return 'airline_a_replace'
  elseif mode ==# 'c'
    return 'airline_a_commandline'
  elseif mode ==# 't'
    return 'airline_a_terminal'
  else
    return 'airline_a'
  endif
endfunction

function! AddLeftmostPowerlineSymbol()
  " Only apply to active window and if airline is loaded
  if !exists('g:loaded_airline') || &buftype ==# 'nofile'
    return
  endif
  
  " Get current statusline
  let current_statusline = &statusline
  
  " Only modify if it's an airline statusline (contains airline function call)
  if current_statusline =~# 'airline#statusline'
    let symbol = s:get_powerline_symbol()
    if !empty(symbol)
      let mode_group = s:get_mode_colors()
      let leftmost_part = '%#' . mode_group . '#' . symbol
      
      " Prepend the symbol to the existing statusline
      let &statusline = leftmost_part . current_statusline
    endif
  endif
endfunction

" Hook into mode changes and window events to update the leftmost symbol
augroup LeftmostPowerline
  autocmd!
  " Update on mode changes
  autocmd ModeChanged * call AddLeftmostPowerlineSymbol()
  " Update when entering windows
  autocmd WinEnter * call AddLeftmostPowerlineSymbol()
  " Update on buffer changes
  autocmd BufEnter * call AddLeftmostPowerlineSymbol()
  " Update after airline refreshes
  autocmd User AirlineAfterInit call AddLeftmostPowerlineSymbol()
augroup END

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
