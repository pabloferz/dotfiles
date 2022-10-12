if get(g:, 'colors_name', '') == 'sonokai'

    hi! link Boolean     Green
    hi! link Character   Green
    hi! link Constant    Green
    hi! link Float       Green
    hi! link Function    Purple
    hi! link Identifier  Green
    hi! link Macro       Orange
    hi! link Number      Green
    hi! link String      Green

    hi! link juliaFunctionCall  Blue

elseif (get(g:, 'colors_name', '') == 'gruvbox-material' || get(g:, 'colors_name', '') == 'everforest')

    hi! link Boolean     Aqua
    hi! link Character   Aqua
    hi! link Float       Aqua
    hi! link Function    Purple
    hi! link Identifier  Aqua
    hi! link Macro       Orange
    hi! link Number      Aqua
    hi! link String      Aqua
    hi! link Type        Blue

    hi! link juliaConstNum      Aqua
    hi! link juliaComplexUnit   Aqua
    hi! link juliaEuler         Aqua
    hi! link juliaFunctionCall  Blue

endif
