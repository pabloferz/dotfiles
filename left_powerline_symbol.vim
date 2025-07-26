" ==============================================================================
" Left Powerline Symbol Extension for vim-airline
" ==============================================================================
" This extension adds a powerline symbol at the leftmost position of the
" statusline that follows the same coloring as the current mode configuration.
"
" Installation:
" 1. Save this file as ~/.vim/autoload/airline/extensions/left_powerline_symbol.vim
"    OR place it in your plugin directory structure under autoload/airline/extensions/
" 2. Add to your .vimrc: let g:airline#extensions#left_powerline_symbol#enabled = 1
" 3. Optionally configure the symbol: let g:airline#extensions#left_powerline_symbol#symbol = ""
"
" ==============================================================================

scriptencoding utf-8

" Default configuration
if !exists('g:airline#extensions#left_powerline_symbol#enabled')
  let g:airline#extensions#left_powerline_symbol#enabled = 0
endif

if !exists('g:airline#extensions#left_powerline_symbol#symbol')
  " Use a powerline symbol that works well at the left edge
  " This is the left-pointing triangle commonly used in powerline
  let g:airline#extensions#left_powerline_symbol#symbol = ""
endif

function! airline#extensions#left_powerline_symbol#init(ext)
  " Only initialize if the extension is enabled
  if !g:airline#extensions#left_powerline_symbol#enabled
    return
  endif
  
  " Add our function to the statusline pipeline
  call airline#add_statusline_func('airline#extensions#left_powerline_symbol#apply')
endfunction

function! airline#extensions#left_powerline_symbol#apply(...)
  " Get the builder and context from vim-airline
  let builder = a:1
  let context = a:2
  
  " Get the symbol to display
  let symbol = g:airline#extensions#left_powerline_symbol#symbol
  
  " Add our symbol as the very first section with mode coloring
  " Using airline_a coloring ensures it matches the mode colors
  call builder.add_section('airline_a', symbol)
  
  " Return 0 to continue with normal statusline building
  return 0
endfunction

" Auto-load this extension when vim-airline loads extensions
let g:airline#extensions#left_powerline_symbol#loaded = 1