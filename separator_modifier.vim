" ==============================================================================
" Separator/Background Modifier for vim-airline
" ==============================================================================
" This modifies vim-airline's separator rendering to add a powerline symbol
" at the left edge, extending the background without changing section content.
" ==============================================================================

scriptencoding utf-8

" Configuration
if !exists('g:airline_left_edge_symbol')
  let g:airline_left_edge_symbol = ""
endif

" Store the original airline separator functions
let s:original_get_sep = function('airline#builder#get_sep')

" Override the separator function to add our left edge symbol
function! airline#builder#get_sep(...)
  " Call the original function first
  let result = call(s:original_get_sep, a:000)
  
  " If this is the very first separator (beginning of statusline)
  " we can modify it to include our symbol
  if a:0 >= 2 && a:2 == 0  " position 0 means leftmost
    let result = g:airline_left_edge_symbol . result
  endif
  
  return result
endfunction

" Alternative approach: Modify the statusline building directly
function! ExtendLeftBackground()
  " Get the current statusline
  let current_statusline = &statusline
  
  " Find section A and prepend our symbol with the same highlighting
  let symbol = g:airline_left_edge_symbol
  
  " Replace the beginning of the statusline to include our symbol
  if current_statusline =~ '%#airline_a#'
    let &statusline = substitute(current_statusline, '%#airline_a#', '%#airline_a#' . symbol, '')
  endif
endfunction

" Set up autocmd to apply our modification
augroup airline_left_edge
  autocmd!
  autocmd User AirlineAfterInit call ExtendLeftBackground()
  autocmd CursorMoved,CursorMovedI * call ExtendLeftBackground()
augroup END