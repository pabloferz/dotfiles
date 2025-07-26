" ==============================================================================
" Minimal Left Edge Background Extension - Add to .vimrc
" ==============================================================================
" This extends section A's background to the left with a powerline symbol
" WITHOUT modifying airline_section_a content at all.
" ==============================================================================

" Your preferred symbol
let g:left_edge_symbol = ""

" Function to extend the background
function! ExtendLeftBackground()
  if !exists('g:loaded_airline') || !g:loaded_airline
    return
  endif
  
  " Get current statusline
  let sl = &statusline
  
  " Only modify if it contains airline and doesn't already have our symbol
  if sl =~ 'airline_a' && sl !~ escape(g:left_edge_symbol, '[]^$.*\~')
    " Method 1: Prepend symbol with airline_a highlighting
    let &statusline = '%#airline_a#' . g:left_edge_symbol . sl
  endif
endfunction

" Apply the modification after airline builds statusline
augroup extend_left_background
  autocmd!
  autocmd User AirlineAfterInit call ExtendLeftBackground()
  autocmd BufEnter,WinEnter * call ExtendLeftBackground()
  autocmd InsertEnter,InsertLeave * call ExtendLeftBackground()
augroup END

" Alternative approach using vim's statusline update events
function! OnStatuslineUpdate()
  call ExtendLeftBackground()
endfunction

" Hook into vim's statusline refresh
autocmd! CursorMoved,CursorMovedI * call OnStatuslineUpdate()

" ==============================================================================
" Even simpler test version (uncomment to try):
" ==============================================================================

" function! SimpleTest()
"   " Just add the symbol at the very beginning with section A colors
"   let &statusline = '%#airline_a#' . g:left_edge_symbol . &statusline
" endfunction
" 
" autocmd User AirlineAfterInit call SimpleTest()

" ==============================================================================
" Instructions:
" 1. Add this entire block to your .vimrc
" 2. Change g:left_edge_symbol to your preferred symbol
" 3. Restart vim
" 4. The symbol should appear at the far left with section A background colors
" 5. Section A content (airline_section_a) remains completely unchanged
" ==============================================================================