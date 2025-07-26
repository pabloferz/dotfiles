" ==============================================================================
" Direct Statusline Modifier - Add to .vimrc
" ==============================================================================
" This directly modifies the statusline after vim-airline builds it to add
" a powerline symbol at the left edge with the same background as section A.
" 
" This approach preserves airline_section_a content completely unchanged.
" ==============================================================================

" Set your preferred symbol
if !exists('g:airline_left_edge_symbol')
  let g:airline_left_edge_symbol = ""
endif

" Function to modify the statusline after airline builds it
function! AddLeftEdgeSymbol()
  " Get the current statusline that airline just built
  let current_sl = &statusline
  
  " Find the first occurrence of airline_a highlighting
  " This marks the beginning of section A
  let pattern = '%#airline_a[^#]*#'
  
  if current_sl =~ pattern
    " Insert our symbol right after the airline_a highlight group starts
    " This makes it appear as part of section A's background
    let replacement = '\0' . g:airline_left_edge_symbol
    let &statusline = substitute(current_sl, pattern, replacement, '')
  endif
endfunction

" Alternative approach using airline's refresh mechanism
function! ModifyAirlineStatusline()
  " Hook into airline's statusline after it's built
  let current_sl = getwinvar(winnr(), '&statusline')
  
  if current_sl =~ '%#airline_a'
    " Add our symbol at the very beginning with airline_a coloring
    let modified_sl = '%#airline_a#' . g:airline_left_edge_symbol . '%#airline_a#' . substitute(current_sl, '^%#airline_a[^#]*#', '', '')
    call setwinvar(winnr(), '&statusline', modified_sl)
  endif
endfunction

" Most direct approach: modify the statusline immediately after airline sets it
function! InterceptStatusline()
  if exists('g:loaded_airline') && g:loaded_airline
    " Wait for airline to set the statusline, then modify it
    let sl = &statusline
    if sl =~ 'airline_a' && sl !~ g:airline_left_edge_symbol
      " Find where section A starts and prepend our symbol
      let &statusline = substitute(sl, '%#airline_a[^#]*#', '\0' . g:airline_left_edge_symbol, '')
    endif
  endif
endfunction

" Set up the modification
augroup airline_left_edge_modifier
  autocmd!
  " Trigger after airline updates the statusline
  autocmd User AirlineAfterInit call InterceptStatusline()
  autocmd BufEnter,WinEnter,CmdwinEnter * call InterceptStatusline()
  autocmd InsertEnter,InsertLeave * call InterceptStatusline()
  autocmd CursorMoved,CursorMovedI * call InterceptStatusline()
augroup END

" ==============================================================================
" Simpler approach for testing
" ==============================================================================

" function! SimpleLeftEdgeTest()
"   " Very direct: just prepend to whatever statusline exists
"   if &statusline =~ 'airline'
"     let current = &statusline
"     " Add symbol at the very beginning with airline_a coloring
"     let &statusline = '%#airline_a#' . g:airline_left_edge_symbol . current
"   endif
" endfunction
" 
" autocmd User AirlineAfterInit call SimpleLeftEdgeTest()

" ==============================================================================
" Instructions:
" 1. Add this to your .vimrc
" 2. Set g:airline_left_edge_symbol to your preferred symbol
" 3. Restart vim
" 4. The symbol should appear at the leftmost edge with section A background
" ==============================================================================