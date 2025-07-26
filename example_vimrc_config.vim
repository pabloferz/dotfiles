" ==============================================================================
" Example .vimrc Configuration for Left Powerline Symbol Extension
" ==============================================================================
" Add these lines to your .vimrc to use the left powerline symbol extension

" ============================================================================
" Basic Setup
" ============================================================================

" Enable vim-airline
let g:airline_powerline_fonts = 1
set laststatus=2

" ============================================================================
" Left Powerline Symbol Extension Configuration
" ============================================================================

" Enable the extension
let g:airline#extensions#left_powerline_symbol#enabled = 1

" ============================================================================
" Symbol Options (choose one, or create your own)
" ============================================================================

" Option 1: Classic powerline triangle (default)
let g:airline#extensions#left_powerline_symbol#symbol = ""

" Option 2: Right-pointing triangle
" let g:airline#extensions#left_powerline_symbol#symbol = ""

" Option 3: Branch/fork symbol
" let g:airline#extensions#left_powerline_symbol#symbol = ""

" Option 4: Lightning bolt
" let g:airline#extensions#left_powerline_symbol#symbol = "⚡"

" Option 5: Arrow
" let g:airline#extensions#left_powerline_symbol#symbol = "→"

" Option 6: Geometric shapes
" let g:airline#extensions#left_powerline_symbol#symbol = "◆"
" let g:airline#extensions#left_powerline_symbol#symbol = "●"
" let g:airline#extensions#left_powerline_symbol#symbol = "■"

" Option 7: Text-based
" let g:airline#extensions#left_powerline_symbol#symbol = "VIM"
" let g:airline#extensions#left_powerline_symbol#symbol = "❯"

" ============================================================================
" Advanced Configuration Options
" ============================================================================

" Use mode colors (recommended for proper theming)
let g:airline#extensions#left_powerline_symbol#use_mode_colors = 1

" Which section colors to use ('a' is mode section, best for color consistency)
let g:airline#extensions#left_powerline_symbol#section = 'a'

" Position in statusline
let g:airline#extensions#left_powerline_symbol#position = 'first'

" ============================================================================
" Alternative Simple Setup (without creating an extension)
" ============================================================================
" If you prefer a simpler approach without creating a separate extension file,
" you can add a powerline symbol directly to section 'a':

" function! AirlineInit()
"   " Add powerline symbol to the beginning of section a
"   call airline#parts#define_function('left_symbol', 'GetLeftSymbol')
"   let g:airline_section_a = airline#section#create_left(['left_symbol', 'mode', 'crypt', 'paste', 'spell', 'iminsert'])
" endfunction

" function! GetLeftSymbol()
"   return ""  " Your preferred symbol here
" endfunction

" autocmd User AirlineAfterInit call AirlineInit()

" ============================================================================
" Theme Compatibility Notes
" ============================================================================
" This extension works with all vim-airline themes because it uses the same
" color scheme as the mode section (section 'a'). The symbol will automatically
" change colors based on:
" - Current vim mode (Normal, Insert, Visual, etc.)
" - Current vim-airline theme
" - Whether the buffer is modified
" - Any other conditions that affect mode coloring

" Popular themes that work well:
" - powerlineish
" - dark
" - solarized
" - molokai
" - base16
" - luna
" - wombat

" To set a theme:
" let g:airline_theme='powerlineish'

" ============================================================================
" Troubleshooting
" ============================================================================
" If the symbol doesn't appear or looks wrong:

" 1. Make sure you have powerline fonts installed and configured
" 2. Verify your terminal supports UTF-8 encoding
" 3. Check if the symbol displays correctly in your terminal:
"    :echo ""
" 4. Try a different symbol if the current one doesn't work
" 5. Restart vim after making configuration changes
" 6. Use :AirlineRefresh to reload airline after changes