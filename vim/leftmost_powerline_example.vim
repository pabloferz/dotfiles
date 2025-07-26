" =============================================================================
" Leftmost Powerline Symbol for vim-airline
" =============================================================================
" This adds a powerline symbol at the leftmost edge of the statusline
" with the same background color as the mode section.
"
" Add this to your vimrc after your vim-airline configuration.
" =============================================================================

" Function to return the leftmost powerline symbol
function! LeftmostPowerlineSymbol()
  " Return the powerline left separator symbol
  " This will be automatically colored by airline's theming system
  return get(g:airline_symbols, 'left_sep', '')
endfunction

" Setup function to integrate with vim-airline
function! SetupLeftmostPowerline()
  " Create a custom function part for the leftmost symbol
  call airline#parts#define_function('leftmost_symbol', 'LeftmostPowerlineSymbol')
  
  " Modify section A to include the leftmost symbol at the beginning
  " This preserves all existing functionality while adding our symbol
  let g:airline_section_a = airline#section#create_left(['leftmost_symbol', 'mode', 'crypt', 'paste', 'spell', 'iminsert'])
  
  " Refresh airline to apply the changes
  if exists(':AirlineRefresh')
    AirlineRefresh
  endif
endfunction

" Hook into airline initialization
" This ensures our modification happens after airline is fully loaded
autocmd User AirlineAfterInit call SetupLeftmostPowerline()

" =============================================================================
" Usage Notes:
" - Requires vim-airline plugin
" - Works best with powerline fonts: let g:airline_powerline_fonts = 1
" - The symbol will inherit the mode section's colors automatically
" - Compatible with all vim-airline themes
" - Preserves all existing airline functionality
" =============================================================================