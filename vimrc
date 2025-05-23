" The Vim configuration with compatibility in mind, for Linux, macOS, and Windows
" Author: Taewoong Han <mail@taewoong.me>

" Remove all the autocommands in vimrc to avoid multiple registration
augroup vimrc
  autocmd!
augroup END

" options {{{1
set ambiwidth=double
set autoindent
set autoread
set backspace=indent,eol,start
set completeopt=menuone,noinsert
set diffopt+=algorithm:histogram,indent-heuristic,vertical
set display=lastline
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,default,latin1
set fileformats=unix,dos,mac
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set infercase
set laststatus=0
set modeline
set nocursorline
set nonumber
set noshowcmd
set nostartofline
set omnifunc=syntaxcomplete#Complete
set pumheight=10
set ruler
set shiftwidth=0    " Use the value of 'tabstop'
set signcolumn=no
set smartcase
set softtabstop=-1  " Use the value of 'tabstop'
set splitbelow
set tabstop=4
set title
set virtualedit=block
set wildmode=longest,list " Complete like Bash

" Store *.swp and viminfo under ~/.vim/.cache (~\vimfiles\.cache on Windows)
let s:cache_dir = expand('<sfile>:p:h') . '/.cache'

let s:swap_dir = s:cache_dir . '/swap'
if !isdirectory(s:swap_dir)
  call mkdir(s:swap_dir, 'p')
endif
let &directory = s:swap_dir . '//'

let &viminfo .= ',n' . s:cache_dir . '/viminfo'

syntax enable

filetype plugin indent on

" Disable the automatic insertion of a comment leader on every file type
autocmd vimrc FileType * setlocal formatoptions-=ro

" variables {{{1
let g:mapleader = "\<Space>"

" Disable the built-in plugins
let g:loaded_2html_plugin      = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logiPat           = 1
let g:loaded_manpager_plugin   = 1
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrw             = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1

let g:markdown_fenced_languages = [
      \ 'bash=sh', 'c', 'cpp', 'cs', 'css', 'html', 'go', 'javascript', 'json',
      \ 'php', 'python', 'ruby', 'rust', 'typescript', 'vim', 'yaml'
      \ ]

" commands {{{1
command! CdHere cd %:h
command! Reload source $MYVIMRC
command! Vimrc  edit $MYVIMRC

" mappings {{{1
nnoremap <C-J> <Cmd>bnext<CR>
nnoremap <C-K> <Cmd>bprevious<CR>

" plugins {{{1
call plug#begin()

Plug 'andymass/vim-matchup'
Plug 'chrisbra/Recover.vim'
Plug 'cohama/lexima.vim'
Plug 'dstein64/vim-startuptime'
Plug 'godlygeek/tabular'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-plug'
Plug 'kana/vim-smartword'
Plug 'lambdalisue/vim-fern'
Plug 'lambdalisue/vim-fern-hijack'
Plug 'lambdalisue/vim-protocol'
Plug 'lambdalisue/vim-suda'
Plug 'machakann/vim-sandwich'
Plug 'markonm/traces.vim'
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rhysd/vim-healthcheck'
Plug 'simeji/winresizer'
Plug 'svermeulen/vim-subversive'
Plug 'thinca/vim-partedit'
Plug 'thinca/vim-qfreplace'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-scripts/mips.vim'

call plug#end()

" Exit vimrc immediately if there are plugins that are not yet installed
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) != 0
  if isdirectory(g:plug_home)
    echohl WarningMsg
    echo 'Warning: There are plugins that are not yet installed.'
    echohl None
  endif

  finish
endif

" cohama/lexima.vim {{{2
let g:lexima_ctrlh_as_backspace = 1
let g:lexima_disable_on_nofile = 1

autocmd vimrc FileType markdown,text let b:lexima_disabled = 1

" Disable the default rules when the cursor is in a comment
call lexima#add_rule({'char': '"', 'input': '"', 'syntax': 'Comment'})
call lexima#add_rule({'char': "'", 'input': "'", 'syntax': 'Comment'})
call lexima#add_rule({'char': '(', 'input': '(', 'syntax': 'Comment'})
call lexima#add_rule({'char': ')', 'input': ')', 'syntax': 'Comment'})
call lexima#add_rule({'char': '[', 'input': '[', 'syntax': 'Comment'})
call lexima#add_rule({'char': ']', 'input': ']', 'syntax': 'Comment'})
call lexima#add_rule({'char': '`', 'input': '`', 'syntax': 'Comment'})
call lexima#add_rule({'char': '{', 'input': '{', 'syntax': 'Comment'})
call lexima#add_rule({'char': '}', 'input': '}', 'syntax': 'Comment'})
call lexima#add_rule({'char': '<BS>', 'input': '<BS>', 'syntax': 'Comment'})
call lexima#add_rule({'char': '<CR>', 'input': '<CR>', 'syntax': 'Comment'})
call lexima#add_rule({'char': '<Space>', 'input': '<Space>', 'syntax': 'Comment'})

" Disable the default rules when the cursor is at the front of a word
call lexima#add_rule({'at': '\%#\w', 'char': "'", 'input': "'"})
call lexima#add_rule({'at': '\%#\w', 'char': '"', 'input': '"'})
call lexima#add_rule({'at': '\%#\w', 'char': '(', 'input': '('})
call lexima#add_rule({'at': '\%#\w', 'char': '[', 'input': '['})
call lexima#add_rule({'at': '\%#\w', 'char': '`', 'input': '`'})
call lexima#add_rule({'at': '\%#\w', 'char': '{', 'input': '{'})

" kana/vim-smartword {{{2
map w <Plug>(smartword-w)
map b <Plug>(smartword-b)
map e <Plug>(smartword-e)
map ge <Plug>(smartword-ge)

" lambdalisue/fern.vim {{{2
nnoremap <Leader>f <Cmd>Fern . -drawer -toggle -stay<CR>

let g:fern_disable_startup_warnings = 1

" ntpeters/vim-better-whitespace {{{2
highlight! link ExtraWhitespace Error

" simeji/winresizer {{{2
let g:winresizer_start_key = '<Leader>e'

" svermeulen/vim-subversive {{{2
nmap s <Plug>(SubversiveSubstitute)
nmap ss <Plug>(SubversiveSubstituteLine)
nmap S <Plug>(SubversiveSubstituteToEndOfLine)

" vim: fdm=marker
