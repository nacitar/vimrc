"%% SiSU Vim color file
:set background=dark
:highlight clear
if version > 580
 hi clear
 if exists("syntax_on")
 syntax reset
 endif
endif

":hi Cursor guibg=khaki guifg=slategrey
" NOTE: assumes background color for terminal is black!
" ctermbg=none can become ctermbg=0 otherwise, but then transparency wont
" work.

let colors_name = "nacitar"
:hi Normal ctermfg=15 ctermbg=none cterm=none guifg=#EEEEEC guibg=#000000 gui=none
:hi VertSplit cterm=reverse gui=reverse
:hi Search ctermfg=0 ctermbg=3 guifg=#000000 guibg=#C4A000
:hi IncSearch ctermfg=0 ctermbg=10 cterm=underline guifg=#000000 guibg=#8AE234 gui=underline
:hi FoldColumn ctermfg=9 ctermbg=none cterm=bold guifg=#FF5555 guibg=#000000 gui=bold
:hi Folded ctermfg=9 ctermbg=none cterm=bold guifg=#FF5555 guibg=#000000 gui=bold
:hi ModeMsg ctermfg=14 cterm=bold  guifg=#34E2E2 gui=bold
:hi MoreMsg ctermfg=14 cterm=bold  guifg=#34E2E2 gui=bold
:hi Title ctermfg=3 cterm=bold  guifg=#C4A000 gui=bold
:hi Question ctermfg=2 cterm=bold  guifg=#4E9A06 gui=bold
:hi NonText ctermfg=13 cterm=bold guifg=#AD7FA8 gui=bold
:hi SpecialKey ctermfg=13 cterm=bold guifg=#AD7FA8 gui=bold
:hi StatusLine ctermfg=15 ctermbg=8 cterm=bold guifg=#EEEEEC guibg=#777777 gui=bold
:hi StatusLineNC ctermfg=8 cterm=reverse guifg=#777777 gui=reverse
:hi Visual cterm=reverse gui=reverse
:hi WarningMsg ctermfg=9 cterm=bold guifg=#FF5555 gui=bold
:hi LineNr ctermfg=3 guifg=#C4A000
:hi Directory ctermfg=6 guifg=#06989A
:hi ErrorMsg ctermfg=15 ctermbg=1 cterm=bold guifg=#EEEEEC guibg=#EF2929 gui=bold
:hi SpellErrors ctermfg=15 ctermbg=1 cterm=bold guifg=#EEEEEC guibg=#EF2929 gui=bold

:hi DiffAdd ctermfg=10 ctermbg=4 cterm=bold guifg=#8AE234 guibg=#3465A4 gui=bold
:hi DiffChange ctermfg=11 ctermbg=5 cterm=bold guifg=#FCE94F guibg=#7C5383 gui=bold
:hi DiffDelete ctermfg=15 ctermbg=1 cterm=bold guifg=#EEEEEC guibg=#EF2929 gui=bold
:hi DiffText ctermfg=14 ctermbg=4 cterm=bold guifg=#34E2E2 guibg=#3465A4 gui=bold
:hi WildMenu ctermfg=0 ctermbg=3 guifg=#000000 guibg=#C4A000
:hi VisualNOS cterm=bold,underline gui=bold,underline

:hi Comment ctermfg=12 cterm=bold guifg=#729FCF gui=bold

:hi Special ctermfg=14 guifg=#34E2E2
:hi SpecialChar ctermfg=14 guifg=#34E2E2
:hi Tag ctermfg=14 guifg=#34E2E2
:hi Delimiter ctermfg=14 guifg=#34E2E2
:hi SpecialComment ctermfg=14 guifg=#34E2E2
:hi Debug ctermfg=14 guifg=#34E2E2

:hi Constant ctermfg=14 guifg=#34E2E2
:hi Character ctermfg=14 guifg=#34E2E2
:hi Number ctermfg=14 guifg=#34E2E2
:hi Boolean ctermfg=14 guifg=#34E2E2
:hi Float ctermfg=14 guifg=#34E2E2
:hi String ctermfg=9 guifg=#FF5555

:hi Identifier ctermfg=9 cterm=bold guifg=#FF5555 gui=bold
:hi Function ctermfg=14 cterm=none guifg=#34E2E2 gui=none

:hi Statement ctermfg=3 cterm=none guifg=#C4A000 gui=none
:hi Conditional ctermfg=3 guifg=#C4A000
:hi Repeat ctermfg=3 guifg=#C4A000
:hi Label ctermfg=3 guifg=#C4A000
:hi Keyword ctermfg=3 guifg=#C4A000
:hi Exception ctermfg=3 guifg=#C4A000
:hi Operator ctermfg=3 guifg=#C4A000

:hi PreProc ctermfg=13 guifg=#AD7FA8
:hi Include ctermfg=13 guifg=#AD7FA8
:hi Define ctermfg=13 guifg=#AD7FA8
:hi Macro ctermfg=13 guifg=#AD7FA8
:hi PreCondit ctermfg=13 guifg=#AD7FA8

:hi Type ctermfg=2 guifg=#4E9A06
:hi StorageClass ctermfg=2 guifg=#4E9A06
:hi Typedef ctermfg=2 guifg=#4E9A06
:hi Structure ctermfg=10 guifg=#8AE234

:hi Underlined ctermfg=5 cterm=underline guifg=#7C5383 gui=underline

:hi Ignore ctermfg=7 cterm=bold guifg=#D3D7CF gui=bold

:hi Error ctermfg=15 ctermbg=1 cterm=bold guifg=#EEEEEC guibg=#EF2929 gui=bold

:hi Todo ctermfg=0 ctermbg=11 guifg=#000000 guibg=#FCE94F

