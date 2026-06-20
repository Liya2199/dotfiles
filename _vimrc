" ===== 基础设置 =====
set nocompatible
syntax on
filetype plugin indent on

set number
set relativenumber
set cursorline
set showmatch
set laststatus=2
set noshowmode
set termguicolors

" 编码和 Windows 友好
set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start
set clipboard=unnamed

" 搜索
set ignorecase
set smartcase
set incsearch
set hlsearch

" 缩进
set expandtab
set shiftwidth=2
set tabstop=2
set smartindent

" FileFomats
set fileformats=unix,dos,mac
" ===== 光标形状：普通模式 vs 插入模式 =====

" GVim 图形界面
set guicursor=n-v-c:block-Cursor
set guicursor+=i-ci-ve:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor

" Windows Terminal / 终端 Vim
" 2 = 方块, 6 = 竖线, 4 = 下划线
let &t_SI = "\e[6 q"  " 插入模式：竖线
let &t_SR = "\e[4 q"  " 替换模式：下划线
let &t_EI = "\e[2 q"  " 普通模式：方块

" ===== 配色 =====
" 用内置的配色就很轻量
set background=dark
" colorscheme desert
colorscheme catppuccin
" 如果你喜欢更现代的，可以试试 habamax / slate / retrobox
" colorscheme habamax

" ===== 状态栏美化 =====
" 左：模式 + 文件名 + 修改标志
" 右：文件类型  编码  行列百分比
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %{mode()=='n'?'NORMAL':mode()=='i'?'INSERT':mode()=='v'?'VISUAL':'REPLACE'}\ 
set statusline+=%#StatusLine#
set statusline+=\ %f\ %m%r%h%w\
set statusline+=%=
set statusline+=%y\ %{&fileencoding?&fileencoding:&encoding}\ 
set statusline+=%#PmenuSel#
set statusline+=\ %l:%c\ %p%%\ 

" ===== 小优化 =====
let mapleader = "\<Space>"
" jk 快速退回普通模式
inoremap jk <Esc>
" 清除搜索高亮
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" 保存
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a
" 终端以及窗口
nnoremap <Leader>tv :vert term<CR> 
nnoremap <Leader>tn :term<CR>
" 用 Ctrl + h/j/k/l 快捷切换左/下/上/右窗口
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 启动时光标回到上次位置
autocmd BufReadPost * if line("'\"")>1 && line("'\"")<=line("$") | exe "normal! g'\"" | endif
