" =============================================================================
" Simple Leftmost Powerline Symbol for vim-airline
" =============================================================================
" This is the basic version of your solution - clean and simple!
" =============================================================================

function! AirlineMod(...)
    let builder = a:1
    let symbol = get(g:airline_symbols, 'left_sep', '')
    call builder.add_raw('%#airline_a#' . symbol)
    return 0
endfunction

call airline#add_statusline_func('AirlineMod')
call airline#add_inactive_statusline_func('AirlineMod')

" =============================================================================
" That's it! This is your original solution - simple and effective.
" 
" If you want inverted colors (foreground/background swapped), 
" use the leftmost_powerline_example.vim version instead.
" ============================================================================="