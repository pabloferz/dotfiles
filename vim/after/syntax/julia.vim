syntax cluster  juliaParScope       contains=@juliaParItems,juliaParBlockInRange
syntax cluster  juliaBlockScope     contains=@juliaBlocksItems,juliaConditionalEIBlock,juliaConditionalEBlock
syntax cluster  juliaTotalScope     contains=@juliaParScope,@juliaMacroItems,@juliaBlockScope
syntax cluster  juliaFunctionScope  contains=juliaFunctionBlock

syntax match    juliaFunctionCall   display "\(function \)\@<!\<\h\w*\>!\?\.\?("me=e-1 containedin=@juliaTotalScope
syntax match    juliaFunctionDef    display "\(function \)\@<=\<\h\w*\>!\?\.\?("me=e-1 containedin=@juliaFunctionScope
syntax match    juliaTypeAssert     display "\(::\)\@<=\<\h\w*\(\.\h\w*\)*\>\([,;{)\n]\)\@=" containedin=@juliaTotalScope

if g:colors_name == 'gruvbox'
    hi def link juliaFunctionCall   GruvboxAqua
    hi def link juliaFunctionDef    GruvboxPurple
    hi def link juliaTypeAssert     GruvboxAqua
    hi link     Boolean             GruvboxAqua
    hi link     Float               GruvboxAqua
    hi link     Macro               GruvboxOrange
    hi link     Number              GruvboxAqua
    hi! link    Constant            GruvboxAqua
    hi! link    String              GruvboxBlue
    hi! link    Type                GruvboxAqua
else
    hi def link juliaFunctionCall   Function
    hi def link juliaFunctionDef    Define
endif

hi link         Operator            Keyword
