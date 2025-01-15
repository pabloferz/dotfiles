if command -v micromamba 2>&1 >/dev/null; then
    eval "$(micromamba shell hook --shell bash)"
fi

if command -v pixi 2>&1 >/dev/null; then
    eval "$(pixi completion --shell bash)"
fi
