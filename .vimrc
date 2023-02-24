"https://learnvimscriptthehardway.stevelosh.com/

"zo=open | zc=close | zR=openAll | zM=closeAll
" Basic Settings --------------------------------- {{{

set foldlevelstart=0
echo ">^.^<"
syntax on
filetype on
filetype plugin on
filetype indent on
colorscheme slate
set number relativenumber tabstop=4 shiftwidth=4 expandtab mouse=a noswapfile
set nocompatible nobackup scrolloff=10 nowrap incsearch ignorecase showcmd
set showmode showmatch hlsearch history=1000 wildmenu wildmode=list:longest
set wildignore=*.docx,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx 

"}}}


" PLUGINS --------------------------------- {{{

call plug#begin('~/.vim/plugged')

  Plug 'dense-analysis/ale'

  Plug 'preservim/nerdtree'

call plug#end()

" }}}


" MAPPINGS  --------------------------------- {{{

"Set the apostrophe as the leader key
let mapleader = "'"

"Movement Mappings
"Guide to defining a new operator-pending movement
"   1. Start at the cursor position.
"   2. Enter visual mode
"   3. ...mapping keys go here...
"   4. All the text you want to include in the movement should now be
"      highlighted
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap il[ :<c-u>normal! F]vi[<cr>
onoremap b /return<cr>
"Try to create similar mappings for around next/last brackets

"Open/source ~/.vimrc 
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"Press '\ to jump back to the last cursor position.
nnoremap <leader>\ ``

"Type jk to exit insert mode quickly. 
inoremap jk <esc>

"Press the space bar to type the : character in normal/command mode
nnoremap <space> :

" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

nnoremap L $
nnoremap H 0

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
nnoremap <F3> :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

"c file specific mapping
augroup filetype_c
    autocmd!
    autocmd FileType c let maplocalleader = "'"
    autocmd FileType c nnoremap <buffer> <localleader>c 0i//<esc>
augroup END

" }}}


" Abbreviations  --------------------------------- {{{

:iabbrev @@ wsiblagan@gmail.com
:iabbrev ccopy Copyright 2023 Wayne Siblagan, all rights reserved

" }}}


" VIMSCRIPT  --------------------------------- {{{

" This will enable code folding.
" Use the marker method for folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup end

" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif


" }}}


" STATUS LINE  --------------------------------- {{{

set statusline=%.20F\ -\ FileType:\%y 
set statusline+=%=
set statusline+=%l\ /\ %-L 
" }}}

