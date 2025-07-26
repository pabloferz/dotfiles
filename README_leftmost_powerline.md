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

The implementation uses vim-airline's `AirlineAfterInit` autocmd event to:

1. Define a custom function part called `leftmost_symbol` that returns the powerline left separator
2. Modify `g:airline_section_a` to prepend this symbol to the existing mode section
3. Preserve all existing functionality (mode display, crypt, paste, spell, iminsert indicators)

## Technical Details

- Uses `airline#parts#define_function()` to create a reusable component
- Leverages `airline#section#create_left()` to properly construct the section
- Respects the `g:airline_symbols` dictionary for powerline symbol configuration
- Automatically inherits the mode section's color scheme through vim-airline's theming system

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