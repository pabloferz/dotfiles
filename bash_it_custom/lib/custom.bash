# Set PATH so it includes user's private bin if it exists
pathmunge "$HOME/bin" after

# Set PATH so it includes user's ~/.local/bin if it exists
pathmunge "$HOME/.local/bin" after
