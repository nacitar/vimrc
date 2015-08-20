" be improved; not legacy vi
set nocompatible

"""""""""""""""""" VUNDLE INITIALIZATION
" add vundle to our runtimepath
let vundle_root = "~/.vim/bundle/"
execute "set rtp+=".vundle_root."vundle"
" start vundle
call vundle#rc()

"""""""""""""""""" VUNDLE CONFIGURATION
" let vundle manage itself
Bundle 'gmarik/vundle'
Bundle 'nacitar/a.vim'
Bundle 'vim-scripts/SudoEdit.vim'
Bundle 'vim-scripts/vcscommand.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/Cpp11-Syntax-Support'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'nacitar/terminalkeys.vim'

"""""""""""""""""" END OF VUNDLE CONFIGURATION

" Support Japanese Shift-JIS encoding
set fileencodings=ucs-bom,utf-8,sjis,default,latin1

" Get rid of delays when pressing escape to change modes
"set timeoutlen=1000 ttimeoutlen=-1

" Make a.vim only match exact filenames, not buffers of the same basename
let g:strictAlternateMatching = 1

filetype on
filetype plugin indent on
syntax on
" syntax highlighting can be slow for really long lines; this fixes it.
set synmaxcol=300

" Set clipboard settings, so selections automatically go to primary, and
" yanking puts things in secondary _and_ primary.
set clipboard=autoselect,unnamed
if has('unnamedplus')
  set clipboard+=unnamedplus
endif

" Support mouse input
set mouse=a
set ttymouse=xterm2

if &term == "rxvt-unicode-256color"
  " assume we're using the mwheel perl addition to handle scrolling as
  " 3-arrow-key presses, so disable builtin mouse support
  map <mousedown> <nop>
  map <mouseup> <nop>
endif

" If using meta8, this will fix alt-hotkeys.
"set termencoding=latin1

" No backup files
set nobackup
set nowritebackup
" We do want swap files; no duplicate editing!
"set noswapfile

" Persistent undo
"
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Automatically indent things
set autoindent
set smartindent

" Enable spellchecking
"setlocal spell spelllang=en

" Use syntax highlighting to control folding
set foldmethod=syntax
" No fold columns
set foldcolumn=0
" Start with all folds open
set foldlevelstart=99

if has('gui_running')
  set guifont=Monospace\ 10
else
  " Enable 256 colors
  if $TERM =~ '256color'
    set t_Co=256
  endif
endif

" Highlight matched search results; you can turn off active highlighting with :noh
set hlsearch
" Highlight upcoming matches while typing in search criteria
set incsearch
" Searches are case-insensitive if they contain all lowercase
set ignorecase
set smartcase
" When searching, scroll to the next search pattern automatically with 7+ lines visible above and below the cursor
set scrolloff=7


function! StyleFunctionDefault(style)
endfunction

" Default keys for the style
let g:nxStyleBase_ = {'useSpace': -1, 'tabWidth': -1, 'columns': -1}
" Style overrides
let w:nxStyle_ = { }
" A place to store custom styles
let g:StyleFunction = 'StyleFunctionDefault'
" Internal; used to keep up with previously applied match patterns
let w:nxStyleMatch_ = ''

function! StyleWindowInit_()
  if !exists('w:nxStyle_')
      let w:nxStyle_ = { }
  endif
  if !exists('w:nxStyleMatch_')
      let w:nxStyleMatch_ = ''
  endif
endfunction

function! StyleApply()
  call StyleWindowInit_()
  " Copy, so we can modify it
  let l:style = copy(g:nxStyleBase_)
  " Call the style function
  call function(g:StyleFunction)(l:style)
  " Include global overrides for values.
  call extend(l:style, w:nxStyle_)
  " General settings
  if l:style.tabWidth != -1
    let &tabstop = l:style.tabWidth
    let &softtabstop = l:style.tabWidth
    let &shiftwidth = l:style.tabWidth
  endif
  if l:style.useSpace != -1
    if l:style.useSpace
      set expandtab
    else
      set noexpandtab
    endif
  endif
  " Apply new match/column settings
  if l:style.columns != -1
    " Remove any old match, if present.
    if w:nxStyleMatch_ != ''
      execute ':match None w:nxStyleMatch_'
    endif
    " Pattern to match trailing whitespace
    let l:matchTrailingWS = '\s\+$'
    if l:style.columns
      " Pattern to match lines that are too long
      let l:matchTooLong = '\%>'.l:style.columns.'v.\+'
      " Set our match to both lines that are too long and trailing whitespace
      let w:nxStyleMatch_ = '\('.l:matchTooLong.'\|'.l:matchTrailingWS.'\)'
      execute ':match ErrorMsg /' . w:nxStyleMatch_ . '/'
      if exists('+colorcolumn')
        let &cc = l:style.columns + 1
      endif
      let &tw = l:style.columns - 1
    else
      " Set our match to trailing whitespace
      let w:nxStyleMatch_ = l:matchTrailingWS
      execute ':match ErrorMsg /' . w:nxStyleMatch_ . '/'
      if exists('+colorcolumn')
        let &cc = ''
      endif
      let &tw = 0
    endif
  endif
endfunction

function! Style(key, value)
  call StyleWindowInit_()
  if has_key(g:nxStyleBase_, a:key)
    if a:value == -1
      " Remove the overrides if blank
      if has_key(w:nxStyle_, a:key)
        unlet w:nxStyle_[a:key]
      endif
    else
      execute 'let w:nxStyle_.' . a:key . ' = a:value'
    endif
    call StyleApply()
  endif
endfunction

function! StyleClear()
  let w:nxStyle_ = {}
  call StyleApply()
endfunction

" Apply settings any time the filetype changes
au FileType * call StyleApply()

""""""""""""""""""""""""""""""""""
"""""""""" BELOW GOES INTO USER FILES
""""""""""""""""""""""""""""""""""

" Detect c++ files, including google-style extensions
au BufRead,BufNewFile *.cc,*.cpp,*.h,*.hpp set filetype=cpp
" Assume Cpp11-Syntax-Support is installed, and change cpp to cpp11
au FileType cpp set filetype=cpp11


" Default to personal settings
function! StyleMode(name)
  if index(['personal', 'anycol', 'work'], a:name) >= 0
    let w:styleMode = a:name
    call StyleApply()
  else
    echoerr 'Unknown style mode: ' . a:name
  endif
endfunction
function! StyleProvider(style)
  if !exists('w:styleMode')
    let w:styleMode = ''
  endif
  if w:styleMode == 'work'
    call extend(a:style,
        \{'useSpace': 0, 'tabWidth': 4, 'columns': 0})
  elseif index(['personal', 'anycol'], w:styleMode) >= 0
    let a:style.useSpace = 1
    if &filetype == 'python'
      let a:style.tabWidth = 4
    else
      let a:style.tabWidth = 2
    endif
    if w:styleMode == 'anycol'
      let a:style.columns = 0
    else
      let a:style.columns = 80
    endif
  endif
endfunction
let g:StyleFunction = 'StyleProvider'
call StyleMode('personal')
"call StyleMode('work')

""""""""""""""""""""""""""""""""""
"""""""""" ABOVE GOES INTO USER FILES
""""""""""""""""""""""""""""""""""

" Enable ctags
set tags=./tags;/

" To filter a colors file for cgdbrc
" cat colors.vim | sed -n 's/^:hi[[:space:]]\+\(Normal\|Statement\|Type\|Constant\|Comment\|PreProc\|StatusLine\|IncSearch\)[[:space:]]\+/hi \1 /p' | sed 's/gui[^=]*=[^[:space:]]*//g'
" Then just adjust the cterm= parts to set the normal states to match, as it doesn't inherit it.
"
" Choose our color scheme
colors nacitar

" Set a nicer foldtext function that matches indentation level
set foldtext=MyFoldText()
function! MyFoldText()
  let lines = 1 + v:foldend - v:foldstart
  let ind = indent(v:foldstart)

  let spaces = ''
  let i = 0
  while i < ind
    let spaces .= ' '
    let i += 1
  endwhile

  let linestxt = 'lines'
  if lines == 1
    linestxt = 'line'
  endif

  let firstline = getline(v:foldstart)
  let line = firstline[ind : ind+80]

  return spaces . '+' . v:folddashes . ' ' . lines . ' ' . linestxt . ': ' . line . ' '
endfunction

" Parameters use tmux's terminology
function! SetTitle(window,pane)
  if match(&term,'^screen\($\|-.*$\)') == 0
    " as a hack, add the window name part to ts, so both get set
    if a:window != ""
      let &t_ts = "\ek".a:window."\e\\"
    endif
    " pane title prefix
    let &t_ts .= "\e]2"
    let &t_fs = "\e\\"

    " trigger the set
    let &titlestring = a:pane
  else
    let &titlestring = a:pane
  endif

endfunction

function! PathShortenTail(pathstr)
  return substitute(pathshorten(a:pathstr),"^[^~/]","/&","")
  " shorten the path, and prepend a / if not starting with ~ or / already
  "return substitute(substitute(pathshorten(a:pathstr . "/."),"/.$","",""),"^[^~]","/&","")
endfunction
" Set custom title that matches vim's default title
function! SetCustomTitle()
  let dirname = expand("%:p:~")
  " don't update it again needlessly
  if exists('g:last_title_dir')
    if dirname == g:last_title_dir
      return
    endif
  endif
  let g:last_title_dir = dirname

  " Check for the no-file case
  let filename = "[No Name]"
  if dirname != ""
    " split it, get the filename, remove the filename, put it back
    let splitdir = split(dirname,'/')
    " we want the empty token before /, too
    if dirname[0] == '/'
      let splitdir = [''] + splitdir
    endif
    let splitlen = len(splitdir)
    if splitlen == 1
      " either ~ or /
      let dirname = dirname[0]
      let filename = '.'
    elseif splitlen > 1
      let filename = splitdir[-1]
      call remove(splitdir,-1)
      let dirname = join(splitdir,'/')
      if dirname == ""
        let dirname = '/'
      endif
    else
      let dirname = ""
    endif
  endif

  let panetitle = filename
  let windowtitle = panetitle
  if dirname != ""
    let panetitle = panetitle . " (" . dirname . ")"
    " shorten path for window title only
    let windowtitle = windowtitle . " (" . PathShortenTail(dirname) . ")"
  endif
  " If remote, add the hostname
  if $SSH_CLIENT != ""
    let prefix = split(hostname(),'\.')[0] . ": "
    let panetitle = prefix . panetitle
    let windowtitle = prefix . windowtitle
  endif
  " Set the window and pane titles, adding a suffix to the pane.
  call SetTitle(windowtitle,panetitle . " - VIM")
endfunction

" Always show the statusline
set laststatus=2

" Enable use of titlestring for a custom title
set title

" Format the statusline, and cause status line changes to invoke our custom
" title function (so it works correctly in the file explorer).  Only works
" if a statusline is visible, though.
set statusline=%<\ %F%(\ %m%w%y%r%)\ %a%=\ %8l,%c%V/%L\ (%P)\ [%08O:%02B]%{SetCustomTitle()}\ 

" If you don't show a statusline, this will work in most cases anyway
auto BufEnter * call SetCustomTitle()

" Enable modelines
set modeline

" Make netbeans-like mappings to the xterm keycodes for some arrow keys
" Select all
" <C-A>
map <C-a> <Esc>ggVG

" Move line down (and auto indent)
" <A-S-Down>
nmap <A-S-Down> :m+<CR>==
imap <A-S-Down> <Esc>:m+<CR>==gi
vmap <A-S-Down> :m'>+<CR>gv=gv

" Move line up (and auto indent)
" <A-S-Up>
nmap <A-S-Up> :m-2<CR>==
imap <A-S-Up> <Esc>:m-2<CR>==gi
vmap <A-S-Up> :m-2<CR>gv=gv

" Move line right
" <A-S-Right>
nmap <A-S-Right> >>
imap <A-S-Right> <Esc>>>i
vmap <A-S-Right> >gv

" Move line left
" <A-S-Left>
nmap <A-S-Left> <<
imap <A-S-Left> <Esc><<i
vmap <A-S-Left> <gv

" Copy line up
" <C-S-Up>
" uses mark T
nmap <C-S-Up> mT:co .-1<Enter>`T<Up>
imap <C-S-Up> <Esc>:co .<Enter>gi
vmap <C-S-Up> :co '><<Enter>gv

" Copy line down
" <C-S-Down>
" uses mark T
nmap <C-S-Down> mT:co .<Enter>`T<Down>
imap <C-S-Down> <Esc>:co .<Enter>gi<Down>
vmap <C-S-Down> :co .-1<Enter>gv

" Change tab left/right (Both alt and control versions, in case your terminal supports control)
" vim already does ctrl-pgup/down, but only in normal mode
"map <silent> <C-PageUp> :tabp<Enter>
"map <silent> <C-PageDown> :tabn<Enter>
nmap <silent> <A-PageUp> <C-PageUp>
nmap <silent> <A-PageDown> <C-PageDown>
" Move tab left/right
nmap <silent> <C-S-PageUp> :execute 'silent! tabmove ' . (tabpagenr()-2)<Enter>
nmap <silent> <C-S-PageDown> :execute 'silent! tabmove ' . tabpagenr()<Enter>
nmap <silent> <A-S-PageUp> <C-S-PageUp>
nmap <silent> <A-S-PageDown> <C-S-PageDown>

" Refer to delete with xterm keycodes; using terminalkeys.vim for now
"nmap <C-Delete> [3;5~
"nmap <A-Delete> [3;3~
" add tab navigation
nmap <C-Insert> :tabnew<CR>
nmap <C-Delete> :tabclose<CR>
nmap <A-Insert> <C-Insert>
nmap <A-Delete> <C-Delete>

" Scroll 3 lines at a time, or 1 if alt is held
" note that the mwheel urxvt perl script already does this translation,
" so in that configuration vim will never get this message.
map <ScrollWheelUp>     3<Up>
map <ScrollWheelDown>   3<Down>
map <M-ScrollWheelUp>   <Up>
map <M-ScrollWheelDown> <Down>

" Toggle NERDTree
nmap <C-L> <ESC>:NERDTreeToggle<CR>
" Toggle taglist
nmap <C-K> <ESC>:TlistToggle<CR>

" Call root vimrc if root
if $USER == "root" && $SUDO_USER != ""
  " TODO: make this get the home directory
  let $tmp = "/root"
  let $root_vimrc = $tmp . "/.vimrc"
  if filereadable($root_vimrc)
    source $root_vimrc
  endif
endif

