" ==============================================================================
" Advanced Left Powerline Symbol Extension for vim-airline
" ==============================================================================
" This extension adds a configurable powerline symbol at the leftmost position
" of the statusline with full mode-appropriate coloring support.
"
" Installation:
" 1. Save this file as ~/.vim/autoload/airline/extensions/left_powerline_symbol.vim
" 2. Add to your .vimrc to enable: let g:airline#extensions#left_powerline_symbol#enabled = 1
"
" Configuration options:
" - g:airline#extensions#left_powerline_symbol#symbol = ""  " The symbol to display
" - g:airline#extensions#left_powerline_symbol#use_mode_colors = 1  " Use mode colors (default)
" - g:airline#extensions#left_powerline_symbol#section = 'a'  " Which section colors to use
" - g:airline#extensions#left_powerline_symbol#position = 'first'  " Position in statusline
"
" ==============================================================================

scriptencoding utf-8

" ============================================================================
" Configuration Variables
" ============================================================================

if !exists('g:airline#extensions#left_powerline_symbol#enabled')
  let g:airline#extensions#left_powerline_symbol#enabled = 0
endif

if !exists('g:airline#extensions#left_powerline_symbol#symbol')
  " Default powerline symbol - you can change this to any symbol you prefer
  " Common powerline symbols:
  "  "" (left triangle)
  "  "" (right triangle) 
  "  "" (branch symbol)
  "  "" (lock symbol)
  "  "⚡" (lightning bolt)
  let g:airline#extensions#left_powerline_symbol#symbol = ""
endif

if !exists('g:airline#extensions#left_powerline_symbol#use_mode_colors')
  let g:airline#extensions#left_powerline_symbol#use_mode_colors = 1
endif

if !exists('g:airline#extensions#left_powerline_symbol#section')
  " Which airline section coloring to use ('a', 'b', 'c', 'x', 'y', 'z')
  " Section 'a' typically contains the mode and has the most prominent colors
  let g:airline#extensions#left_powerline_symbol#section = 'a'
endif

if !exists('g:airline#extensions#left_powerline_symbol#position')
  " Position in the statusline: 'first' or 'before_mode'
  let g:airline#extensions#left_powerline_symbol#position = 'first'
endif

" ============================================================================
" Extension Functions
" ============================================================================

function! airline#extensions#left_powerline_symbol#init(ext)
  if !g:airline#extensions#left_powerline_symbol#enabled
    return
  endif
  
  " Register our extension with vim-airline
  call airline#add_statusline_func('airline#extensions#left_powerline_symbol#apply')
  
  " Define a part for our symbol with proper coloring
  call airline#parts#define('left_powerline_symbol', {
    \ 'function': 'airline#extensions#left_powerline_symbol#get_symbol',
    \ 'accents': 'bold'
  \ })
endfunction

function! airline#extensions#left_powerline_symbol#get_symbol()
  " Return the configured symbol
  return g:airline#extensions#left_powerline_symbol#symbol
endfunction

function! airline#extensions#left_powerline_symbol#apply(...)
  let builder = a:1
  let context = a:2
  
  " Determine which section coloring to use
  let section_name = 'airline_' . g:airline#extensions#left_powerline_symbol#section
  
  if g:airline#extensions#left_powerline_symbol#position ==# 'first'
    " Add as the very first element
    call builder.add_section(section_name, g:airline#extensions#left_powerline_symbol#symbol)
  endif
  
  return 0
endfunction

" ============================================================================
" Alternative Integration Methods
" ============================================================================

" Method 2: Modify existing sections
function! airline#extensions#left_powerline_symbol#modify_sections()
  if !g:airline#extensions#left_powerline_symbol#enabled
    return
  endif
  
  " Get the current section a content
  let current_section_a = get(g:, 'airline_section_a', airline#section#create_left(['mode', 'crypt', 'paste', 'spell', 'iminsert']))
  
  " Prepend our symbol to section a
  let symbol_part = g:airline#extensions#left_powerline_symbol#symbol
  let g:airline_section_a = airline#section#create_left([symbol_part]) . current_section_a
endfunction

" Method 3: Use airline's built-in customization
function! airline#extensions#left_powerline_symbol#setup_via_sections()
  if !g:airline#extensions#left_powerline_symbol#enabled
    return
  endif
  
  " Define our symbol as a part
  call airline#parts#define_function('left_symbol', 'airline#extensions#left_powerline_symbol#get_symbol')
  
  " Modify section a to include our symbol
  let g:airline_section_a = airline#section#create_left(['left_symbol', 'mode', 'crypt', 'paste', 'spell', 'iminsert'])
endfunction

" ============================================================================
" Auto-initialization
" ============================================================================

" Set up the extension when the file is loaded
augroup airline_left_powerline_symbol
  autocmd!
  autocmd User AirlineAfterInit call airline#extensions#left_powerline_symbol#setup_via_sections()
augroup END