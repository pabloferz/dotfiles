" ==============================================================================
" Function-Based Statusline Solution - Add to .vimrc
" ==============================================================================
" This works with vim-airline's function-based statusline by intercepting
" the function that builds the statusline and modifying its output.
" ==============================================================================

" Your preferred symbol
let g:left_edge_symbol = ""

" Debug function to see what airline is doing
function! DebugStatusline()
  echo "statusline: " . &statusline
  echo "airline loaded: " . (exists('g:loaded_airline') ? g:loaded_airline : 'not loaded')
  if exists('*airline#statusline')
    echo "airline#statusline function exists"
  endif
endfunction

" Hook into airline's statusline building function
let s:original_statusline_func = ''

function! InterceptAirlineStatusline(winnr)
  " Call the original airline statusline function
  let result = ''
  
  " Try to get the original result
  if exists('*airline#statusline')
    let result = airline#statusline(a:winnr)
  elseif exists('s:original_statusline_func') && !empty(s:original_statusline_func)
    let result = call(s:original_statusline_func, [a:winnr])
  endif
  
  " Add our symbol to the beginning with airline_a coloring
  if !empty(result)
    let result = '%#airline_a#' . g:left_edge_symbol . result
  endif
  
  return result
endfunction

" Store original function and replace it
function! SetupFunctionIntercept()
  if exists('*airline#statusline')
    " Store reference to original function
    let s:original_statusline_func = function('airline#statusline')
    
    " Replace airline's statusline function with our interceptor
    function! airline#statusline(winnr)
      return InterceptAirlineStatusline(a:winnr)
    endfunction
  endif
endfunction

" Alternative approach: Use airline's own extension system properly
function! AddLeftSymbolToBuilder(...)
  let builder = a:1
  let context = a:2
  
  " Add symbol as the very first thing with section A highlighting
  call builder.add_section('airline_a', g:left_edge_symbol)
  
  return 0
endfunction

function! SetupBuilderHook()
  " Use airline's proper extension mechanism
  call airline#add_statusline_func('AddLeftSymbolToBuilder')
endfunction

" Try different initialization methods
function! InitializeLeftEdge()
  " Method 1: Try function interception
  call SetupFunctionIntercept()
  
  " Method 2: Try builder hook
  call SetupBuilderHook()
  
  " Method 3: Direct manipulation for function-based statuslines
  if &statusline =~ '%(.*%)'
    " If statusline is function-based, we need to work differently
    let &statusline = '%{g:left_edge_symbol}' . &statusline
  endif
endfunction

" Set up with multiple triggers
augroup function_based_left_edge
  autocmd!
  autocmd User AirlineAfterInit call InitializeLeftEdge()
  autocmd VimEnter * call InitializeLeftEdge()
augroup END

" Manual trigger for testing
command! DebugAirline call DebugStatusline()
command! SetupLeftEdge call InitializeLeftEdge()

" ==============================================================================
" Simple function-based approach for testing
" ==============================================================================

function! SimpleLeftEdgeFunction()
  " Return just our symbol - this can be used in statusline
  return g:left_edge_symbol
endfunction

function! SetupFunctionTest()
  " Add our function to the beginning of statusline
  if &statusline =~ '%!'
    " Function-based statusline - insert our function call
    let &statusline = '%{SimpleLeftEdgeFunction()}' . &statusline
  elseif &statusline =~ 'airline'
    " String-based - prepend normally  
    let &statusline = '%#airline_a#' . g:left_edge_symbol . &statusline
  endif
endfunction

" Uncomment to try the function test:
" autocmd User AirlineAfterInit call SetupFunctionTest()

" ==============================================================================
" Instructions:
" 1. Add this to your .vimrc
" 2. Run :DebugAirline to see what type of statusline you have
" 3. Try :SetupLeftEdge to manually trigger setup
" 4. If nothing works, uncomment the SetupFunctionTest line above
" ==============================================================================