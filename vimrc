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

" Leftmost powerline symbol with inverted colors
function! CreateInvertedModeHighlights()
  " Create inverted highlight groups for each mode
  " These will have the foreground and background colors swapped
  
  " Get the current airline theme colors
  let palette = g:airline#themes#{g:airline_theme}#palette
  
  " Define inverted highlight groups for each mode
  for mode in ['normal', 'insert', 'visual', 'replace', 'commandline', 'terminal']
    if has_key(palette, mode)
      let mode_colors = palette[mode]['airline_a']
      " Swap fg and bg colors: [fg, bg, ctermfg, ctermbg, opts]
      let inverted_colors = [mode_colors[1], mode_colors[0], mode_colors[3], mode_colors[2], get(mode_colors, 4, '')]
      
      " Create the inverted highlight group
      let group_name = 'airline_a_' . mode . '_inverted'
      if mode ==# 'normal'
        let group_name = 'airline_a_inverted'
      endif
      
      call airline#highlighter#exec(group_name, inverted_colors)
    endif
  endfor
endfunction

function! GetCurrentModeInvertedGroup()
  " Return the appropriate inverted highlight group based on current mode
  let mode = mode()
  if mode ==# 'i'
    return 'airline_a_insert_inverted'
  elseif mode =~# '\v[vV\<C-v>]'
    return 'airline_a_visual_inverted'
  elseif mode ==# 'R'
    return 'airline_a_replace_inverted'
  elseif mode ==# 'c'
    return 'airline_a_commandline_inverted'
  elseif mode ==# 't'
    return 'airline_a_terminal_inverted'
  else
    return 'airline_a_inverted'
  endif
endfunction

function! AirlineMod(...)
  let builder = a:1
  let context = a:2
  
  " Only add to active statusline
  if get(context, 'active', 0)
    " Get the inverted highlight group for current mode
    let inverted_group = GetCurrentModeInvertedGroup()
    
    " Add the powerline symbol with inverted colors
    let symbol = get(g:airline_symbols, 'left_sep', '')
    call builder.add_raw('%#' . inverted_group . '#' . symbol)
  endif
  
  return 0
endfunction

" Setup the inverted highlights after airline initializes
function! SetupInvertedHighlights()
  call CreateInvertedModeHighlights()
  
  " Add our statusline modification functions
  call airline#add_statusline_func('AirlineMod')
  call airline#add_inactive_statusline_func('AirlineMod')
endfunction

" Hook into airline theme changes to recreate inverted highlights
augroup LeftmostPowerlineInverted
  autocmd!
  autocmd User AirlineAfterInit call SetupInvertedHighlights()
  autocmd User AirlineAfterTheme call CreateInvertedModeHighlights()
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
