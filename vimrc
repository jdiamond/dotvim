" vim:fdm=marker

" This is Vim, not vi.
set nocompatible

" This is the default on everywhere except Windows.
set runtimepath^=~/.vim
set runtimepath+=~/.vim/after

" Vundle docs require turning filetype off at first.
filetype off

" Turn on Vundle.
set rtp+=~/.vim/vundle/
call vundle#rc()

" Bundles go here.
Bundle 'DetectIndent'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'

" Enable filetype detection. Must be after bundles get added.
filetype plugin indent on

" Hitting the , key is more convenient than \ key.
let mapleader = ","

" Always show a status line.
set laststatus=2

" Customize the status line.
if has("statusline")
  set statusline=%t " tail of the filename
  set statusline+=%m " modified flag
  set statusline+=%r " read-only flag
  set statusline+=%= " left/right separator
  set statusline+=%y " filetype
  set statusline+=\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",bom\":\"\").\"]\"} " fileencoding
  set statusline+=\ %{\"[\".&ff.\"]\"} " fileformat
  set statusline+=\ %{\"[\".&ts.\"/\".&sts.\"/\".&sw.\"/\".(&et?\"et\":\"noet\").\"]\"} " tab settings
  set statusline+=\ %{\"[\".&tw.\"]\"} " textwidth
  set statusline+=\ %-14.(%l,%c%V%) " line and column
  set statusline+=\ %P " percentage
endif

" Default foldlevel to not fold.
set foldlevelstart=99

" Default to show special characters.
set list

" Glyphs for whitespace characters when list is toggled on.
set listchars=tab:>\ ,trail:-

" Shortcut to rapidly toggle `set list`.
nmap <leader>l :set list!<CR>:set list?<CR>

" Shortcut to rapidly toggle `set wrap`.
"nmap <leader>w :set wrap!<CR>:set wrap?<CR>
" ,w is mapped by the camelcasemotion plugin.

" Shortuct to toggle textwidth.
nmap <leader>W :call ToggleTextWidth()<CR>
function! ToggleTextWidth()
  if &textwidth != 0
    let b:oldtextwidth = &textwidth
    set textwidth=0
  elseif exists("b:oldtextwidth")
    let &textwidth = b:oldtextwidth
  else
    set textwidth=79
  endif
endfunction

" Highlight the current line.
set cursorline

" Always us the OS clipboard.
set clipboard=unnamed

" Unmap the arrow keys.
nmap <right> <nop>
nmap <left> <nop>
nmap <up> <nop>
nmap <down> <nop>
imap <right> <nop>
imap <left> <nop>
imap <up> <nop>
imap <down> <nop>

" Fix up and down so that they work on wrapped lines.
nnoremap j gj
nnoremap k gk

" Enable syntax highlighting.
syntax enable

" Make it easy to swith buffers.
set hidden

" Set the default encoding for files.
set encoding=utf-8

" Don't bother backing up.
set nobackup
set nowritebackup
set noswapfile

" Make the backspace key act normal.
set backspace=eol,indent,start

set ignorecase " Ignore case when searching.
set smartcase " Override ignorecase if pattern contains uppercase characters.
set hlsearch " Highlight search matches.
set incsearch " Search while typing.
nnoremap <leader><space> :noh<CR>

set showmatch " Highlight matching brackets.
set matchtime=2 " Tenths of a second to highlight matching brackets.

" Stop beeping at me!
set noerrorbells
set visualbell
set t_vb=

set textwidth=79 " Wrap lines at column 79.
set nojoinspaces " Don't add two spaces at the end of sentences.
set colorcolumn=81 " Show a line at column 81.

" Set tabstop, softtabstop and shiftwidth to the same value {{{
" From http://vimcasts.org/episodes/tabs-and-spaces/
command! -nargs=* Stab call Stab()

function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:ts = l:tabstop
    let &l:sts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    end
  finally
    echohl None
  endtry
endfunction
" }}}

" Duplicate lines {{{

" Duplicate line in normal mode.
noremap <leader>d yyp

" Duplicate selection in visual mode.
vnoremap <leader>d y'>p

" }}}

" Quickfix {{{

" Function for jumping to the next quickfix and cycling back to the beginning
" when reaching the end.
noremap <leader>n :call NextQuickfix()<CR>
function! NextQuickfix()
  let v:errmsg = ""
  silent! cnext
  if v:errmsg != ""
    " If there's an error message, we must be at the end of the list.
    crewind
    if ! getqflist()[0]['valid']
      " If the first error isn't a real error, jump to the next one.
      cnext
    endif
  else
    " Redisplay the current error so that the message appears.
    cc
  endif
endfunction

" }}}

let g:snippets_dir = '~/.vim/snippets'

" FileType Auto Commands {{{

augroup HtmlAutoCommands
  autocmd!
  autocmd FileType html setlocal ts=4 sts=4 sw=4 noet tw=0
augroup END

augroup JavaScriptAutoCommands
  autocmd!
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noet tw=0
augroup END

augroup PythonAutoCommands
  autocmd!
  autocmd FileType python setlocal ts=8 sts=4 sw=4 et tw=0

  " Set things up so that Python files can be run from within Vim.
  autocmd FileType python compiler pyunit
  autocmd FileType python setlocal makeprg=python
augroup END

augroup AllAutoCommands
  autocmd!

  " Try to detect the indetation settings.
  autocmd BufReadPost * :DetectIndent
augroup END

" }}}

" CtrlP Options {{{

let g:ctrlp_map = '<leader>f'
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>r :CtrlPMRUFiles<CR>

" }}}
