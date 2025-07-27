" =============================================================================
" Leftmost Powerline Symbol for vim-airline (with inverted colors)
" =============================================================================
" This adds a powerline symbol at the leftmost edge of the statusline
" with inverted colors (foreground/background swapped) relative to the mode section.
"
" Add this to your vimrc after your vim-airline configuration.
" =============================================================================

" Create inverted highlight groups for each mode
function! CreateInvertedModeHighlights()
  let palette = g:airline#themes#{g:airline_theme}#palette
  
  for mode in ['normal', 'insert', 'visual', 'replace', 'commandline', 'terminal']
    if has_key(palette, mode)
      let mode_colors = palette[mode]['airline_a']
      " Swap fg and bg colors: [fg, bg, ctermfg, ctermbg, opts]
      let inverted_colors = [mode_colors[1], mode_colors[0], mode_colors[3], mode_colors[2], get(mode_colors, 4, '')]
      
      let group_name = 'airline_a_' . mode . '_inverted'
      if mode ==# 'normal'
        let group_name = 'airline_a_inverted'
      endif
      
      call airline#highlighter#exec(group_name, inverted_colors)
    endif
  endfor
endfunction

" Get the appropriate inverted highlight group for current mode
function! GetCurrentModeInvertedGroup()
  let mode = mode()
  if mode ==# 'i'
    return 'airline_a_insert_inverted'
  elseif mode =~# '\v[vV\<C-v>]'
    return 'airline_a_visual_inverted'
  elseif mode ==# 'R'
    return 'airline_a_replace_inverted'
  elseif mode ==# 'c'
    return 'airline_a_commandline_inverted'
  elseif mode ==# 't'
    return 'airline_a_terminal_inverted'
  else
    return 'airline_a_inverted'
  endif
endfunction

" Main function to add the leftmost powerline symbol
function! AirlineMod(...)
  let builder = a:1
  let context = a:2
  
  " Only add to active statusline
  if get(context, 'active', 0)
    let inverted_group = GetCurrentModeInvertedGroup()
    let symbol = get(g:airline_symbols, 'left_sep', '')
    call builder.add_raw('%#' . inverted_group . '#' . symbol)
  endif
  
  return 0
endfunction

" Setup function
function! SetupInvertedHighlights()
  call CreateInvertedModeHighlights()
  call airline#add_statusline_func('AirlineMod')
  call airline#add_inactive_statusline_func('AirlineMod')
endfunction

" Hook into airline events
augroup LeftmostPowerlineInverted
  autocmd!
  autocmd User AirlineAfterInit call SetupInvertedHighlights()
  autocmd User AirlineAfterTheme call CreateInvertedModeHighlights()
augroup END

" =============================================================================
" Usage Notes:
" - Requires vim-airline plugin
" - Works best with powerline fonts: let g:airline_powerline_fonts = 1
" - The symbol will have inverted colors relative to the mode section
" - Compatible with all vim-airline themes
" - Automatically updates when themes change
" - Uses vim-airline's proper builder.add_raw() API
" =============================================================================