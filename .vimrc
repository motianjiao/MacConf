""
"" Janus setup
""

" Define paths
if has('win32') || has('win64') || has('win32unix')
  let g:janus_path = escape(expand("~/.vim/janus/vim"), ' ')
  let g:janus_vim_path = escape(expand("~/.vim/janus/vim"), ' ')
else
  let g:janus_path = escape(fnamemodify(resolve(expand("<sfile>:p")), ":h"), ' ')
  let g:janus_vim_path = escape(fnamemodify(resolve(expand("<sfile>:p" . "vim")), ":h"), ' ')
endif
let g:janus_custom_path = expand("~/.janus")

" Source janus's core
exe 'source ' . g:janus_vim_path . '/core/before/plugin/janus.vim'
" You should note that groups will be processed by Pathogen in reverse

" order they were added.
call janus#add_group("tools")
call janus#add_group("langs")
call janus#add_group("colors")

""
"" Customisations
""

if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif


" Disable plugins prior to loading pathogen
exe 'source ' . g:janus_vim_path . '/core/plugins.vim'

""
"" Pathogen setup
""

" Load all groups, custom dir, and janus core
call janus#load_pathogen()

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature'
Plug 'morhetz/gruvbox'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-abolish'
Plug 'vimwiki/vimwiki'
Plug 'leafgarland/typescript-vim'

" Syntax Highlighting
filetype on
filetype plugin on
syntax enable

" Searching
set incsearch hlsearch smartcase
highlight Search guibg=grey guifg=white
highlight Search cterm=NONE ctermfg=white ctermbg=darkgrey

" Color column, but only if we exceed.
highlight ColorColumn ctermbg=darkred ctermfg=black
call matchadd('ColorColumn', '\%80v', 100)

" Setting toggle for word wrapping and line numbering. Useful for copying
" from vim buffer to clipboard.
noremap <F3> :set invnumber invwrap<CR>

" Highlight the active buffer's current line number.
highlight clear CursorLine
highlight CursorLineNR ctermbg=grey ctermfg=black
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

au BufNewFile,BufRead *.ng setf html
au BufNewFile,BufRead *.textproto setf javascript
nmap <F6> :NERDTreeToggle<CR>

color elflord

" Use I to start editing at the end of the line above
nnoremap I kA
nnoremap K jA
inoremap KK <ESC>jA

" Use qq to enter normal mode
vnoremap qq <Esc>
inoremap qq <Esc>
vnoremap QQ <Esc>
inoremap QQ <Esc>

" auto move cursor left
inoremap <> <><Left>
inoremap () ()<Left>
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap `` ``<Left>

" Creates a line in between after enter
inoremap {}<CR> {}<Left><CR><ESC>O
inoremap ()<CR> ()<Left><CR><ESC>O
inoremap []<CR> []<Left><CR><ESC>O
inoremap <><CR> <><Left><CR><ESC>O
inoremap ""<CR> ""<Left><CR><ESC>O
inoremap ``<CR> ``<Left><CR><ESC>O
inoremap ''<CR> ''<Left><CR><ESC>O

" Enable curosr move in input mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" repeat o to create new line in input mode
inoremap OO <ESC>o

" also enable file save in input mode
inoremap :w<CR> <ESC>:w<CR>

" insert at end of line with A even in input node
inoremap AA <ESC>A
inoremap :" <ESC>A
nnoremap :" A

nnoremap <Tab>   >>
nnoremap <S-Tab> <<
nnoremap f 5j
nnoremap F 5k
nnoremap W 5l
nnoremap B 5h

vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv
vnoremap f 5j
vnoremap F 5k

" javascript function complete
inoremap :>> <ESC>A<space>=><space>{}<Left><CR><ESC>O
nnoremap :>> A<space>=><space>{}<Left><CR><ESC>O

inoremap :{} <ESC>A<space>{}<Left><CR><ESC>O
nnoremap :{} A<space>{}<Left><CR><ESC>O

inoremap :; <ESC>A;<CR>

" remap Enter to create new empty line
nnoremap <CR> o<ESC>S
