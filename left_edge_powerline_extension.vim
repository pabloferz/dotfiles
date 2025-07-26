" ==============================================================================
" Left Edge Powerline Symbol Extension for vim-airline
" ==============================================================================
" This extension extends the leftmost background (mode section) with a powerline
" symbol by modifying the mode display itself, creating a seamless left edge.
"
" Installation:
" 1. Save this file as ~/.vim/autoload/airline/extensions/left_edge_powerline.vim
" 2. Add to your .vimrc: let g:airline#extensions#left_edge_powerline#enabled = 1
" 3. Optionally configure: let g:airline#extensions#left_edge_powerline#symbol = ""
"
" ==============================================================================

scriptencoding utf-8

" ============================================================================
" Configuration Variables
" ============================================================================

if !exists('g:airline#extensions#left_edge_powerline#enabled')
  let g:airline#extensions#left_edge_powerline#enabled = 0
endif

if !exists('g:airline#extensions#left_edge_powerline#symbol')
  " Default powerline symbol for left edge
  let g:airline#extensions#left_edge_powerline#symbol = ""
endif

if !exists('g:airline#extensions#left_edge_powerline#separator')
  " Separator between symbol and mode (usually a space)
  let g:airline#extensions#left_edge_powerline#separator = " "
endif

" ============================================================================
" Extension Functions
" ============================================================================

function! airline#extensions#left_edge_powerline#init(ext)
  if !g:airline#extensions#left_edge_powerline#enabled
    return
  endif
  
  " Override the default mode function to include our symbol
  call airline#parts#define_function('mode', 'airline#extensions#left_edge_powerline#mode_with_symbol')
endfunction

function! airline#extensions#left_edge_powerline#mode_with_symbol()
  " Get the original mode text
  let mode_text = airline#parts#mode()
  
  " Get our symbol and separator
  let symbol = g:airline#extensions#left_edge_powerline#symbol
  let separator = g:airline#extensions#left_edge_powerline#separator
  
  " Combine symbol with mode text
  return symbol . separator . mode_text
endfunction

" Alternative approach using section modification
function! airline#extensions#left_edge_powerline#modify_mode_section()
  if !g:airline#extensions#left_edge_powerline#enabled
    return
  endif
  
  " Define a custom mode part that includes our symbol
  call airline#parts#define_function('enhanced_mode', 'airline#extensions#left_edge_powerline#get_enhanced_mode')
  
  " Replace the mode part in section a with our enhanced version
  let g:airline_section_a = airline#section#create_left(['enhanced_mode', 'crypt', 'paste', 'spell', 'iminsert'])
endfunction

function! airline#extensions#left_edge_powerline#get_enhanced_mode()
  " Get current mode
  let current_mode = mode()
  let mode_map = get(g:, 'airline_mode_map', {})
  
  " Use airline's mode mapping or fall back to the mode character
  let mode_text = get(mode_map, current_mode, current_mode)
  
  " Add our symbol
  let symbol = g:airline#extensions#left_edge_powerline#symbol
  let separator = g:airline#extensions#left_edge_powerline#separator
  
  return symbol . separator . mode_text
endfunction

" ============================================================================
" Auto-initialization
" ============================================================================

" Set up the extension when airline initializes
augroup airline_left_edge_powerline
  autocmd!
  autocmd User AirlineAfterInit call airline#extensions#left_edge_powerline#modify_mode_section()
augroup END