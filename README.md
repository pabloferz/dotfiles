# Vim-Airline Left Powerline Symbol Extension

A vim-airline extension that adds a configurable powerline symbol at the left end of the statusline with mode-appropriate coloring.

## Features

- ✨ Adds a powerline symbol at the leftmost position of your statusline
- 🎨 Automatically matches the current mode colors (Normal, Insert, Visual, etc.)
- ⚙️ Fully configurable symbol and positioning
- 🔧 Works with all vim-airline themes
- 📦 Easy installation and setup

## Installation

### Method 1: Extension File (Recommended)

1. **Create the extension file:**
   ```bash
   # Create the directory if it doesn't exist
   mkdir -p ~/.vim/autoload/airline/extensions
   
   # Copy the extension file
   cp left_powerline_symbol_advanced.vim ~/.vim/autoload/airline/extensions/left_powerline_symbol.vim
   ```

2. **Add to your `.vimrc`:**
   ```vim
   " Enable the extension
   let g:airline#extensions#left_powerline_symbol#enabled = 1
   
   " Configure your preferred symbol (optional)
   let g:airline#extensions#left_powerline_symbol#symbol = ""
   ```

### Method 2: Simple .vimrc Configuration

If you prefer not to create a separate extension file, add this to your `.vimrc`:

```vim
function! AirlineInit()
  " Add powerline symbol to the beginning of section a
  call airline#parts#define_function('left_symbol', 'GetLeftSymbol')
  let g:airline_section_a = airline#section#create_left(['left_symbol', 'mode', 'crypt', 'paste', 'spell', 'iminsert'])
endfunction

function! GetLeftSymbol()
  return ""  " Your preferred symbol here
endfunction

autocmd User AirlineAfterInit call AirlineInit()
```

## Configuration

### Basic Configuration

```vim
" Enable the extension
let g:airline#extensions#left_powerline_symbol#enabled = 1

" Set your preferred symbol
let g:airline#extensions#left_powerline_symbol#symbol = ""
```

### Available Symbols

Choose from these popular powerline symbols:

| Symbol | Description | Unicode |
|--------|-------------|---------|
| `` | Left triangle (default) | U+E0B0 |
| `` | Right triangle | U+E0B0 |
| `` | Branch symbol | U+E0A0 |
| `` | Lock symbol | U+E0A2 |
| `⚡` | Lightning bolt | U+26A1 |
| `→` | Arrow | U+2192 |
| `◆` | Diamond | U+25C6 |
| `●` | Circle | U+25CF |
| `■` | Square | U+25A0 |
| `❯` | Chevron | U+276F |

### Advanced Configuration

```vim
" Use mode colors (default: 1)
let g:airline#extensions#left_powerline_symbol#use_mode_colors = 1

" Which section colors to use (default: 'a')
let g:airline#extensions#left_powerline_symbol#section = 'a'

" Position in statusline (default: 'first')
let g:airline#extensions#left_powerline_symbol#position = 'first'
```

## How It Works

The extension integrates with vim-airline's color system to ensure the symbol always matches your current mode:

- **Normal mode**: Uses your theme's normal mode colors
- **Insert mode**: Uses insert mode colors (usually different/brighter)
- **Visual mode**: Uses visual mode colors
- **Replace mode**: Uses replace mode colors
- And so on...

The symbol automatically updates its appearance based on:
- Current vim mode
- Current airline theme
- Buffer modification status
- Any other conditions affecting mode colors

## Compatibility

- ✅ Works with all vim-airline themes
- ✅ Compatible with Vim 7.2+
- ✅ Works with Neovim
- ✅ Supports both GUI and terminal vim
- ✅ Compatible with powerline fonts

### Tested Themes

- powerlineish
- dark
- solarized
- molokai
- base16
- luna
- wombat

## Troubleshooting

### Symbol doesn't appear
1. Make sure vim-airline is installed and working
2. Verify the extension is enabled: `:echo g:airline#extensions#left_powerline_symbol#enabled`
3. Restart vim after making changes
4. Use `:AirlineRefresh` to reload airline

### Symbol looks wrong or broken
1. Install powerline fonts: [powerline/fonts](https://github.com/powerline/fonts)
2. Configure your terminal to use a powerline font
3. Verify UTF-8 encoding: `:set encoding=utf-8`
4. Test the symbol directly: `:echo ""`
5. Try a different symbol if the current one doesn't work in your setup

### Colors don't match
1. Ensure you're using `section = 'a'` for mode colors
2. Check if your theme supports the airline_a highlight group
3. Try `:AirlineRefresh` after mode changes

## Examples

### Different Symbol Configurations

```vim
" Classic powerline look
let g:airline#extensions#left_powerline_symbol#symbol = ""

" Branch/git style
let g:airline#extensions#left_powerline_symbol#symbol = ""

" Modern minimal
let g:airline#extensions#left_powerline_symbol#symbol = "❯"

" Vim branding
let g:airline#extensions#left_powerline_symbol#symbol = "VIM"
```

### Complete .vimrc Example

```vim
" Basic vim-airline setup
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'

" Enable left powerline symbol
let g:airline#extensions#left_powerline_symbol#enabled = 1
let g:airline#extensions#left_powerline_symbol#symbol = ""
```

## Contributing

Feel free to submit issues and pull requests to improve this extension!

## License

This extension follows the same license as vim-airline (MIT License).
