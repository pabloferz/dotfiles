" ==============================================================================
" Minimal Left Edge Powerline Symbol - Add to .vimrc
" ==============================================================================
" This extends the mode section background with a powerline symbol at the left.
" The symbol will have the same background color as the mode (section A).
" ==============================================================================

" Set your preferred symbol
let g:left_powerline_symbol = ""

" Function to get mode with symbol prefix
function! ModeWithSymbol()
  return g:left_powerline_symbol . " " . airline#parts#mode()
endfunction

" Setup function to modify section A
function! SetupLeftPowerlineSymbol()
  " Define the enhanced mode part
  call airline#parts#define_function('mode_with_symbol', 'ModeWithSymbol')
  
  " Replace section A to use our enhanced mode
  let g:airline_section_a = airline#section#create_left(['mode_with_symbol', 'crypt', 'paste', 'spell', 'iminsert'])
endfunction

" Apply after airline loads
autocmd User AirlineAfterInit call SetupLeftPowerlineSymbol()

" ==============================================================================
" Alternative even more direct approach (if above doesn't work):
" ==============================================================================

" function! SetupDirectSymbol()
"   " Get current section A
"   let current_section = get(g:, 'airline_section_a', '')
"   " Prepend symbol to section A
"   let g:airline_section_a = g:left_powerline_symbol . " " . current_section
" endfunction
" 
" autocmd User AirlineAfterInit call SetupDirectSymbol()

" ==============================================================================
" Instructions:
" 1. Add this entire block to your .vimrc
" 2. Change the symbol in g:left_powerline_symbol if desired
" 3. Restart vim or :source ~/.vimrc
" 4. The symbol should appear at the leftmost edge with mode colors
" ==============================================================================