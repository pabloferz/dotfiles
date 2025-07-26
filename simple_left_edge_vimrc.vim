" ==============================================================================
" Simple Left Edge Powerline Symbol for vim-airline
" ==============================================================================
" Add this to your .vimrc to extend the mode section background with a 
" powerline symbol at the left edge.
"
" This modifies the mode display itself rather than creating a separate section,
" so the symbol appears as part of the same colored background as the mode.
" ==============================================================================

" ============================================================================
" Configuration
" ============================================================================

" The symbol to display at the left edge (choose your preferred symbol)
let g:left_edge_powerline_symbol = ""

" Alternative symbols you can use:
" let g:left_edge_powerline_symbol = ""   " Right-pointing triangle
" let g:left_edge_powerline_symbol = ""   " Branch symbol
" let g:left_edge_powerline_symbol = "⚡"   " Lightning bolt
" let g:left_edge_powerline_symbol = "◆"   " Diamond
" let g:left_edge_powerline_symbol = "❯"   " Chevron

" ============================================================================
" Implementation
" ============================================================================

function! EnhancedMode()
  " Get the current mode using airline's mode function
  let mode_text = airline#parts#mode()
  
  " Add our symbol to the beginning
  return g:left_edge_powerline_symbol . " " . mode_text
endfunction

function! SetupLeftEdgePowerline()
  " Define our enhanced mode function as a part
  call airline#parts#define_function('enhanced_mode', 'EnhancedMode')
  
  " Replace section a to use our enhanced mode instead of the default mode
  let g:airline_section_a = airline#section#create_left(['enhanced_mode', 'crypt', 'paste', 'spell', 'iminsert'])
endfunction

" Set up the enhancement after airline initializes
autocmd User AirlineAfterInit call SetupLeftEdgePowerline()

" ============================================================================
" Alternative Simpler Approach
" ============================================================================
" If the above doesn't work as expected, you can try this even simpler approach:

" function! SetupLeftEdgePowerlineSimple()
"   " Directly modify the mode part to include our symbol
"   call airline#parts#define_text('mode', g:left_edge_powerline_symbol . ' ' . airline#parts#mode())
" endfunction
" 
" autocmd User AirlineAfterInit call SetupLeftEdgePowerlineSimple()

" ============================================================================
" Direct Section Override (Most Direct Approach)
" ============================================================================
" This approach directly overrides section_a with a custom string that includes
" the symbol and mode:

" function! GetModeWithSymbol()
"   let current_mode = mode()
"   
"   " Default mode map (airline uses a more comprehensive one)
"   let mode_map = {
"     \ 'n': 'NORMAL',
"     \ 'i': 'INSERT', 
"     \ 'v': 'VISUAL',
"     \ 'V': 'V-LINE',
"     \ "\<C-v>": 'V-BLOCK',
"     \ 'R': 'REPLACE',
"     \ 's': 'SELECT',
"     \ 'S': 'S-LINE',
"     \ "\<C-s>": 'S-BLOCK',
"     \ 'c': 'COMMAND',
"     \ 't': 'TERMINAL'
"   \ }
"   
"   let mode_text = get(mode_map, current_mode, current_mode)
"   return g:left_edge_powerline_symbol . " " . mode_text
" endfunction
" 
" function! SetupDirectModeOverride()
"   call airline#parts#define_function('symbol_mode', 'GetModeWithSymbol')
"   let g:airline_section_a = airline#section#create_left(['symbol_mode', 'crypt', 'paste', 'spell', 'iminsert'])
" endfunction
" 
" autocmd User AirlineAfterInit call SetupDirectModeOverride()

" ============================================================================
" Usage Instructions
" ============================================================================
" 1. Add the configuration section above to your .vimrc
" 2. Choose your preferred symbol by setting g:left_edge_powerline_symbol
" 3. Uncomment one of the implementation approaches (the first one is recommended)
" 4. Restart vim or run :source ~/.vimrc
" 5. The symbol should now appear at the left edge of your statusline with the same
"    background color as the mode section

" Note: Make sure you have vim-airline installed and properly configured:
" set laststatus=2
" let g:airline_powerline_fonts = 1  " If you have powerline fonts