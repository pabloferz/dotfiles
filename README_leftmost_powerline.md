# Leftmost Powerline Symbol for vim-airline

This configuration adds a powerline symbol at the leftmost edge of the vim-airline statusline, extending the visual background of the mode section to create a seamless appearance.

## Features

- **Background Extension**: Adds a powerline symbol at the very left edge without modifying the actual content of `airline_section_a`
- **Mode Color Matching**: The symbol automatically follows the same coloring as the current mode configuration (Normal, Insert, Visual, etc.)
- **Seamless Integration**: Preserves all existing vim-airline functionality while enhancing the visual appearance
- **Powerline Font Support**: Uses the appropriate powerline symbols when `g:airline_powerline_fonts = 1` is set

## Visual Effect

Instead of the statusline starting like:
```
| NORMAL |
```

It will now look like:
```
|  NORMAL |
```

Where `` is the powerline left separator symbol that appears at the very left edge with the same background color as the mode section.

## How It Works

The implementation works by modifying the final statusline string after vim-airline has generated it, which means:

1. **No Section Content Changes**: `airline_section_a` and all other sections remain completely untouched
2. **Visual Background Extension**: The powerline symbol is prepended to the final statusline with the appropriate mode colors
3. **Event-Driven Updates**: Uses autocmd events (`ModeChanged`, `WinEnter`, etc.) to update when the mode or window changes
4. **Preserves All Functionality**: All existing vim-airline features, themes, and extensions continue to work normally

## Technical Details

- Modifies the final `&statusline` string after vim-airline has set it
- Uses vim's `ModeChanged`, `WinEnter`, and `BufEnter` autocmd events for real-time updates
- Respects the `g:airline_symbols` dictionary for powerline symbol configuration
- Dynamically determines the correct highlight group based on the current vim mode
- Only applies to windows with airline statuslines (detected by checking for `airline#statusline` in the statusline)

## Requirements

- vim-airline plugin
- Powerline-patched fonts (recommended for best appearance)
- `let g:airline_powerline_fonts = 1` in your vimrc

## Compatibility

This modification is designed to be:
- Non-intrusive: doesn't break existing vim-airline functionality
- Theme-agnostic: works with any vim-airline theme
- Mode-aware: adapts colors based on current vim mode
- Performance-friendly: minimal overhead

## Troubleshooting

If the symbol doesn't appear or looks incorrect:

1. Ensure powerline fonts are installed and configured
2. Verify `g:airline_powerline_fonts = 1` is set in your vimrc
3. Check that your terminal supports the powerline symbols
4. Try running `:AirlineRefresh` to force a statusline update

The symbol will fall back to an empty string if powerline fonts are not available, so the feature degrades gracefully.