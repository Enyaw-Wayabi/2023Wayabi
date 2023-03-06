"zo=open | zc=close | zR=openAll | zM=closeAll
" BASIC SETTINGS --------------------------------- {{{

set foldlevelstart=0
echo ">^.^<"
syntax on
filetype on
filetype plugin on
filetype indent on
colorscheme slate
set number relativenumber tabstop=4 shiftwidth=4 expandtab mouse=a noswapfile
set nocompatible nobackup scrolloff=10 nowrap incsearch ignorecase showcmd nowrap
set showmode showmatch hlsearch history=1000 wildmenu wildmode=list:longest
set wildignore=*.docx,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx 

"}}}


" PLUGINS --------------------------------- {{{

call plug#begin('~/.vim/plugged')

  Plug 'dense-analysis/ale'

  Plug 'preservim/nerdtree'

call plug#end()


execute pathogen#infect()

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
onoremap L :<c-u>normal! v$h<cr>

"Toggle the quickfix window
nnoremap <leader>q :call QuickfixToggle()<cr>

"Indent the file
nnoremap <leader><tab> mqgg=G'q

"Toggle column fold
nnoremap <leader>f :call FoldColumnToggle()<cr>

"Toggle relative numbers
nnoremap <leader>N :setlocal relativenumber!<cr>

"Grep that's
"grep-operator defined in plugins folder
nnoremap gn :cnext<cr>
nnoremap gp :cprevious<cr>

"Insert \v to search using normal regex syntax
nnoremap <leader>/ /\v
nnoremap <leader>? ?\v

"Highlight trailing whitespaces as an error
highlight Trailing ctermbg=yellow guibg=yellow
"nnoremap <leader>w :execute "match Trailing " . '/\v\s+$/'<cr>
"nnoremap <leader>W :execute "match none  " . '/\v\s+$/'<cr>
nnoremap <leader>w :match Trailing /\v\s+$/<cr>
nnoremap <leader>W :match none /\v\s+$/<cr>

"Remove highlighted search
nnoremap <leader>n :nohlsearch<cr>

"Open/source ~/.vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"Open previous buffer
nnoremap pb :execute "rightbelow split " . bufname("#")<cr>

"Start vim comment
nnoremap <leader>" i"

"appends semicolon ';' to end of line
nnoremap <leader>; mqA;<esc>'q

"Type jk to exit insert mode quickly.
inoremap jk <esc>

"Press the space bar to type the : character in normal/command mode
nnoremap <space> :

" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

nnoremap L $
nnoremap H k$w

nnoremap I i<space><space><space><space><esc>l
 
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
    autocmd FileType c nnoremap <buffer> <localleader>cc 0i//<esc>
augroup END

" }}}


" Abbreviations  --------------------------------- {{{

":iabbrev @@ wsiblagan@gmail.com
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

"Toggle Fold Column
function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=1
    endif
endfunction

"Toggle quickfix window
let g:quickfix_is_open = 0
 
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif 
endfunction


" }}}


" FUNCTIONAL  --------------------------------- {{{

"Read and understand the following functions ONE MORE TIME before commenting
function! Sorted(l)
    let new_list = deepcopy(a:l)
    call sort(new_list)
    return(new_list)
endfunction

function! Reversed(l)
    let new_list = deepcopy(a:l)
    call reverse(new_list)
    return new_list
endfunction

function! Append(l, val)
    let new_list = deepcopy(a:l)
    call add(new_list, a:val)
    return new_list
endfunction

function! Assoc(l, i, val)
    let new_list = deepcopy(a:l)
    let new_list[a:i] = a:val
    return new_list
endfunction

function! Pop(l, i)
    let new_list = deepcopy(a:l)
    call remove(new_list, a:i)
    return new_list
endfunction

function! Mapped(fn, l)
    let new_list = deepcopy(a:l)
    call map(new_list, string(a:fn) . '(v:val)')
    return new_list
endfunction

function! Filtered(fn, l)
    let new_list = deepcopy(a:l)
    call filter(new_list, string(a:fn) . '(v:val)')
    return new_list
endfunction

function! Removed(fn, l)
    let new_list = deepcopy(a:l)
    call filter(new_list, '!' . string(a:fn) . '(v:val)')
    return new_list
endfunction

function! Reduced(fn, l)
    let [acc; tail] = a:l
    while !empty(tail)
        let [head; tail] = tail
        let acc = a:fn(acc, head)
    endwhile
    return acc
endfunction

"}}}


" STATUS LINE  --------------------------------- {{{

set statusline=%.20F\ -\ FileType:\%y 
set statusline+=%=
set statusline+=%l\ /\ %-L 
" }}}


