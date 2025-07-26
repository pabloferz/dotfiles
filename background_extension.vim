" ==============================================================================
" Background Extension for vim-airline
" ==============================================================================
" This extension modifies the visual rendering of section A to extend the
" background leftward with a powerline symbol, without changing the content.
"
" Installation:
" 1. Save as ~/.vim/autoload/airline/extensions/background_extension.vim
" 2. Add to .vimrc: let g:airline#extensions#background_extension#enabled = 1
" ==============================================================================

scriptencoding utf-8

if !exists('g:airline#extensions#background_extension#enabled')
  let g:airline#extensions#background_extension#enabled = 0
endif

if !exists('g:airline#extensions#background_extension#symbol')
  let g:airline#extensions#background_extension#symbol = ""
endif

function! airline#extensions#background_extension#init(ext)
  if !g:airline#extensions#background_extension#enabled
    return
  endif
  
  " Hook into the statusline building process
  call airline#add_statusline_func('airline#extensions#background_extension#apply')
endfunction

function! airline#extensions#background_extension#apply(...)
  let builder = a:1
  let context = a:2
  
  " Get the symbol
  let symbol = g:airline#extensions#background_extension#symbol
  
  " Add the symbol as a separate section but with the same highlight as section A
  " This creates the visual effect of extending section A's background
  call builder.add_section('airline_a', symbol)
  
  return 0
endfunction