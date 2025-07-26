" ==============================================================================
" Working Solution for Function-Based Statusline - Add to .vimrc
" ==============================================================================
" This works by using vim-airline's builder system correctly to extend 
" the background without modifying section content.
" ==============================================================================

" Your symbol
let g:left_edge_symbol = ""

" The key insight: we need to add our symbol BEFORE airline builds section A
function! AddLeftEdgeToStatusline(...)
  let builder = a:1
  let context = a:2
  
  " Add our symbol as the very first element with airline_a highlighting
  " This extends the background to the left
  call builder.add_section('airline_a', g:left_edge_symbol)
  
  " Return 0 to continue with normal airline processing
  return 0
endfunction

" Set up the hook into airline's building process
function! SetupLeftEdgeExtension()
  " Register our function to be called when building the statusline
  call airline#add_statusline_func('AddLeftEdgeToStatusline')
endfunction

" Initialize after airline loads
autocmd User AirlineAfterInit call SetupLeftEdgeExtension()

" ==============================================================================
" Alternative approach using the left separator override
" ==============================================================================

" Override the left separator to include our symbol
function! CustomLeftSep()
  return g:left_edge_symbol . get(g:airline_symbols, 'left_sep', '')
endfunction

function! SetupCustomSeparator()
  " This modifies how the leftmost separator is drawn
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  
  " Store original separator
  if !exists('g:original_left_sep')
    let g:original_left_sep = get(g:airline_symbols, 'left_sep', '')
  endif
  
  " Set custom separator that includes our symbol
  let g:airline_symbols.left_sep = g:left_edge_symbol . g:original_left_sep
endfunction

" Uncomment to try separator approach:
" autocmd User AirlineAfterInit call SetupCustomSeparator()

" ==============================================================================
" Most direct approach: Prepend to section A content
" ==============================================================================

function! PrependToSectionA()
  " Get current section A
  let current_a = get(g:, 'airline_section_a', airline#section#create_left(['mode', 'crypt', 'paste', 'spell', 'iminsert']))
  
  " Create new section A with our symbol first
  let g:airline_section_a = g:left_edge_symbol . ' ' . current_a
endfunction

" Uncomment to try direct prepend:
" autocmd User AirlineAfterInit call PrependToSectionA()

" ==============================================================================
" Debug and manual controls
" ==============================================================================

" Debug what's happening
function! DebugAirlineSetup()
  echo "statusline: " . &statusline
  echo "section_a: " . get(g:, 'airline_section_a', 'not set')
  echo "symbols: " . string(get(g:, 'airline_symbols', {}))
endfunction

command! DebugAirline call DebugAirlineSetup()
command! SetupLeftEdge call SetupLeftEdgeExtension()

" ==============================================================================
" Instructions:
" 1. Add this to .vimrc (the main approach should work automatically)
" 2. If it doesn't work, try uncommenting one of the alternative approaches
" 3. Use :DebugAirline to see current settings
" 4. Use :SetupLeftEdge to manually trigger setup
" ==============================================================================