" Name:         Hivacruz
" Author:       Yann Defretin <yann@defret.in>
" Maintainer:   Yann Defretin <yann@defret.in>
" Website:      https://github.com/kinoute/vim-hivacruz-theme
" License:      Vim License (see `:help license`)

set background=dark

hi clear

if exists("syntax on")
syntax reset
endif

let g:colors_name = "hivacruz"

set t_Co=256

" Background color for active line
set cursorline
:highlight clear CursorLine
:highlight clear CursorLinNr

let g:colors_name = "hivacruz"

" Define reusable colorvariables.
let s:bg="#152638"
let s:fg="#F8F8F8"
let s:fg2="#e4e4e4"
let s:fg3="#d0d0d0"
let s:fg4="#bcbcbc"
let s:fg5="#00bfd3"
let s:bg2="#283748"
let s:bg3="#3a4958"
let s:bg4="#4d5a68"
let s:bg5="#212431"
let s:keyword="#FF8E30"
let s:builtin="#27C3CA"
let s:const= "#FD861F"
let s:comment="#B87F62"
let s:func="#27C3CA"
let s:str="#FBCE33"
let s:type="#EABF4D"
let s:var="#F8F8F8"
let s:warning="#e81050"
let s:warning2="#e86310"
let s:method="#2ABD90"
let s:integer="#00ACF6"
let s:define="#A982FF"
let s:hexa="#41BC8E"

exe 'hi Normal guifg='s:fg' guibg='s:bg
exe 'hi Cursor guifg='s:bg' guibg='s:fg
exe 'hi CursorLine  guibg='s:bg2
exe 'hi CursorLineNr guifg='s:fg' guibg='s:bg2' gui=none cterm=none'
exe 'hi CursorColumn  guibg='s:bg2
exe 'hi ColorColumn  guibg='s:bg2
exe 'hi LineNr guifg='s:fg4' guibg='s:bg
exe 'hi VertSplit guifg='s:fg3' guibg='s:bg3
exe 'hi MatchParen guifg='s:warning2'  gui=underline cterm=underline'
exe 'hi StatusLine guifg='s:fg2' guibg='s:bg5' gui=bold cterm=bold'
exe 'hi Pmenu guifg='s:fg' guibg='s:bg2
exe 'hi PmenuSel  guibg='s:bg3
exe 'hi IncSearch guifg='s:bg' guibg='s:keyword
exe 'hi Search   gui=underline cterm=underline'
exe 'hi Directory guifg='s:const
exe 'hi Folded guifg='s:fg4' guibg='s:bg
exe 'hi WildMenu guifg='s:str' guibg='s:bg
exe 'hi Visual guifg='s:fg' guibg=#355274'

exe 'hi Boolean guifg='s:const
exe 'hi Character guifg='s:const
exe 'hi Comment guifg='s:comment
exe 'hi Conditional guifg='s:keyword
exe 'hi Constant guifg='s:const
exe 'hi Todo guibg='s:bg
exe 'hi Define guifg='s:keyword
exe 'hi DiffAdd guifg=#fafafa guibg=#123d0f gui=bold cterm=bold'
exe 'hi DiffDelete guibg='s:bg2
exe 'hi DiffChange  guibg=#151b3c guifg=#fafafa'
exe 'hi DiffText guifg=#ffffff guibg=#ff0000 gui=bold cterm=bold'
exe 'hi ErrorMsg guifg='s:warning2' guibg='s:bg2' gui=bold cterm=bold'
exe 'hi WarningMsg guifg='s:fg' guibg='s:warning2
exe 'hi Float guifg='s:integer
exe 'hi Integer guifg='s:integer
exe 'hi Function guifg='s:func
exe 'hi Identifier guifg='s:type'  gui=italic cterm=italic'
exe 'hi Keyword guifg='s:keyword'  gui=bold'
exe 'hi Label guifg='s:var
exe 'hi NonText guifg='s:bg4' guibg='s:bg
exe 'hi Number guifg='s:const
exe 'hi Operator guifg='s:keyword
exe 'hi PreProc guifg='s:keyword
exe 'hi Special guifg='s:fg
exe 'hi SpecialKey guifg='s:fg2' guibg='s:bg2
exe 'hi Statement guifg='s:keyword
exe 'hi StorageClass guifg='s:type'  gui=italic cterm=italic'
exe 'hi String guifg='s:str
exe 'hi Tag guifg='s:keyword
exe 'hi Title guifg='s:fg'  gui=bold cterm=italic'
exe 'hi Todo guifg='s:fg2'  gui=inverse,bold cterm=inverse,bold'
exe 'hi Type guifg='s:type
exe 'hi Underlined   gui=underline cterm=underline'

" Neovim Terminal Mode
let g:terminal_color_0 = s:bg
let g:terminal_color_1 = s:warning
let g:terminal_color_2 = s:keyword
let g:terminal_color_3 = s:bg4
let g:terminal_color_4 = s:func
let g:terminal_color_5 = s:builtin
let g:terminal_color_6 = s:fg3
let g:terminal_color_7 = s:str
let g:terminal_color_8 = s:bg2
let g:terminal_color_9 = s:warning2
let g:terminal_color_10 = s:fg2
let g:terminal_color_11 = s:var
let g:terminal_color_12 = s:type
let g:terminal_color_13 = s:const
let g:terminal_color_14 = s:fg4
let g:terminal_color_15 = s:comment

" Ruby Highlighting
exe 'hi rubyRainbow_lv0_p1 guifg='s:fg
exe 'hi rubyRainbow_lv3_p0 guifg='s:fg
exe 'hi rubySymbol guifg='s:method
" exe 'hi rubyMethodBlock guifg=#27C3CA'
" exe 'hi rubyConditionalExpression guifg=#27C3CA'
exe 'hi rubyConstant guifg='s:type' gui=italic cterm=italic'
exe 'hi rubyComment guifg='s:comment
exe 'hi rubyMagicComment guifg='s:comment
exe 'hi rubyAttribute guifg='s:builtin
exe 'hi rubyLocalVariableOrMethod guifg='s:var
exe 'hi rubyGlobalVariable guifg='s:var' gui=italic cterm=italic'
exe 'hi rubyInstanceVariable guifg='s:var
exe 'hi rubyKeyword guifg='s:keyword
exe 'hi rubyKeywordAsMethod guifg='s:keyword' gui=bold cterm=bold'
exe 'hi rubyClassDeclaration guifg='s:keyword' gui=bold cterm=bold'
exe 'hi rubyClass guifg='s:keyword' gui=bold cterm=bold'
exe 'hi rubyNumber guifg='s:integer
exe 'hi rubyInteger guifg='s:integer
exe 'hi rubyBoolean guifg='s:func

" Disable ALE auto highlights
let g:ale_set_highlights = 0

" Python Highlighting
exe 'hi pythonBuiltinFunc guifg='s:builtin
exe 'hi pythonNumber guifg='s:integer
exe 'hi pythonBoolean guifg='s:func
exe 'hi pythonStrFormatting guifg='s:hexa
exe 'hi pythonHexNumber guifg='s:hexa

" Php highlighting
exe 'hi phpStorageClass guifg=#FC4349'
exe 'hi phpIdentifier guifg='s:fg
exe 'hi phpNumber guifg='s:integer
exe 'hi phpDefine guifg='s:define
exe 'hi phpRegion guifg='s:func
exe 'hi phpType guifg=#FC4349'
exe 'hi phpBoolean guifg='s:func
exe 'hi phpMethodsVar guifg='s:func
exe 'hi phpClass guifg='s:str
exe 'hi phpClassExtends guifg='s:str' gui=italic cterm=italic'
exe 'hi phpNullValue guifg='s:func
exe 'hi phpMethod guifg='s:func

" Go Highlighting
exe 'hi goBuiltins guifg='s:builtin
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints      = 1
let g:go_highlight_chan_whitespace_error  = 1
let g:go_highlight_extra_types            = 1
let g:go_highlight_fields                 = 1
let g:go_highlight_format_strings         = 1
let g:go_highlight_function_calls         = 1
let g:go_highlight_function_parameters    = 1
let g:go_highlight_functions              = 1
let g:go_highlight_generate_tags          = 1
let g:go_highlight_operators              = 1
let g:go_highlight_space_tab_error        = 1
let g:go_highlight_string_spellcheck      = 1
let g:go_highlight_types                  = 1
let g:go_highlight_variable_assignments   = 1
let g:go_highlight_variable_declarations  = 1

" Javascript Highlighting
exe 'hi jsBuiltins guifg='s:builtin
exe 'hi jsFunction guifg='s:define' gui=bold cterm=bold'
exe 'hi jsGlobalObjects guifg='s:type' gui=italic cterm=italic'
exe 'hi jsAssignmentExps guifg='s:var
exe 'hi jsUndefined guifg='s:func
exe 'hi jsNumber guifg='s:integer
exe 'hi jsFuncArgs guifg='s:keyword' gui=italic cterm=italic'
exe 'hi jsBooleanFalse guifg='s:func
exe 'hi jsBooleanTrue guifg='s:func
exe 'hi jsNull guifg='s:func


" Html Highlighting
exe 'hi htmlLink guifg='s:var' gui=underline cterm=underline'
exe 'hi htmlStatement guifg='s:keyword
exe 'hi htmlSpecialTagName guifg='s:keyword
exe 'hi htmlTagName guifg='s:integer
exe 'hi htmlArg guifg='s:keyword
exe 'hi htmlSpecialChar guifg='s:method
exe 'hi htmlEndTag guifg='s:fg
exe 'hi htmlTag guifg='s:fg

" CSS
exe 'hi cssCommonAttr guifg='s:fg
exe 'hi cssValueNumber guifg='s:integer
exe 'hi cssTagName guifg='s:integer
exe 'hi cssTextAttr guifg='s:fg
exe 'hi cssPositioningAttr guifg='s:fg
exe 'hi cssColor guifg='s:hexa
exe 'hi scssSelectorName guifg='s:keyword
exe 'hi scssSelectorChar guifg='s:keyword
exe 'hi cssUnitDecorators guifg='s:hexa
exe 'hi cssValueLength guifg='s:integer
exe 'hi cssValueTime guifg='s:integer
exe 'hi cssFontAttr guifg='s:fg
exe 'hi scssAttribute guifg='s:keyword
exe 'hi cssBoxAttr guifg='s:fg
exe 'hi cssUIAttr guifg='s:fg
exe 'hi cssFlexibleBoxAttr guifg='s:fg
exe 'hi cssBorderAttr guifg='s:fg
exe 'hi cssPseudoClassId guifg='s:fg
exe 'hi cssVendor guifg='s:fg
exe 'hi cssBackgroundAttr guifg='s:fg
exe 'hi scssParameterList guifg='s:keyword
exe 'hi cssTableAttr guifg='s:fg
exe 'hi cssCascadeAttr guifg='s:fg

" Markdown Highlighting
exe 'hi mkdCode guifg=#8AA1E1'
exe 'hi mkdHeading ctermfg=LightYellow guifg=LightYellow'
exe 'hi mkdLink guifg=#27c3ca'
exe 'hi mkdURL guifg=#F0B752'
exe 'hi mkdCodeStart guifg=#8AA1E1'
exe 'hi mkdCodeEnd guifg=#8AA1E1'
autocmd FileType markdown highlight htmlH1 ctermfg=LightYellow

" Yaml
exe 'hi yamlBlockMappingKey guifg='s:integer
exe 'hi yamlPlainScalar guifg='s:str
exe 'hi yamlBool guifg='s:func

" Docker-compose
exe 'hi dockercomposeKeywords guifg='s:integer

" Sh/env/dos
exe 'hi shNumber guifg='s:integer
exe 'hi dosiniNumber guifg='s:integer
exe 'hi dosiniHeader guifg='s:func
exe 'hi dosiniValue guifg='s:fg
exe 'hi shStatement guifg='s:func
exe 'hi shVariable guifg='s:fg
exe 'hi shSetOption guifg='s:keyword
exe 'hi shShebang guifg='s:comment
exe 'hi shSet guifg='s:func
exe 'hi shDerefSimple guifg='s:fg
exe 'hi shDerefVar guifg='s:fg
exe 'hi shParen guifg='s:keyword' cterm=italic gui=italic'
exe 'hi shOption guifg='s:keyword' cterm=italic gui=italic'
exe 'hi zshVariableDef guifg='s:func

" Nginx
exe 'hi ngxDirectiveBlock guifg='s:define
exe 'hi ngxDirective guifg='s:keyword
exe 'hi ngxDirectiveImportant guifg='s:keyword
exe 'hi ngxInteger guifg='s:integer
exe 'hi ngxBoolean guifg='s:func

" Json
exe 'hi jsonKeyword guifg='s:keyword' gui=italic cterm=italic'

" XML
exe 'hi xmlTagName guifg='s:integer
exe 'hi xmlAttrib guifg='s:integer

" Vim
exe 'hi vimCommand guifg='s:func
exe 'hi vimNumber guifg='s:integer
exe 'hi vimNotation guifg='s:keyword' cterm=italic gui=italic'
exe 'hi vimVar guifg='s:fg
exe 'hi NERDTreeDir guifg='s:func
