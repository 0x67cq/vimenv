" TOC
" ===================== customize-vim-opt =====================
"
" ===================== set keymapping =====================
"
" ===================== customize-common-package =====================
"
" ===================== load-common-package =====================

" 关闭vi兼容
set nocompatible
" 开启文件类型检查与文件类型插件
filetype on
filetype plugin indent on


" ===================== customize-vim-opt =====================
" =====Mac剪贴板共享=====
set clipboard=unnamed

" =====文件=====
" 设置编码格式
set encoding=utf-8
set termencoding=utf-8

" 文件修改自动载入
set autoread
" 覆盖文件不备份
set nobackup
" 关闭交换文件
set noswapfile

" =====命令行=====

" 菜单补全
set completeopt-=preview
" 历史命令容量
set history=2000
" 命令行智能补全
set wildmenu
set wildmode=longest:full,full
" 忽略文件
set wildignore+=*.swp,*.pyc,*.pyo,.idea,.git
" wildmode增强
let &wildcharm = &wildchar
cnoremap <expr> / wildmenumode() ? "\<Down>" : "/"

" =====状态栏=====

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 显示当前正在输入的命令
set showcmd
" 允许有未保存时切换缓冲区
set hidden

" =====行号=====

" 相对行号
set relativenumber number
" 当前窗口用相对行号，其他窗口绝对行号
autocmd WinEnter * if &number | execute("setlocal number relativenumber") | endif
autocmd WinLeave * if &number | execute("setlocal number norelativenumber") | endif
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :setlocal norelativenumber number
autocmd InsertLeave * :setlocal relativenumber number

" =====内容=====

" 禁止拆行
set nowrap
" 高亮显示当前行
set cursorline

" 提高画面流畅度
set lazyredraw
set ttyfast

" 禁止折叠
set nofoldenable
set noshowmode    "Hide the default mode text (e.g. -- INSERT -- below the statusline)

" 显示tab跟空格
set list
set listchars=tab:>-,trail:·,nbsp:·

" 指定分割的区域
set splitbelow
set splitright

" 垂直滚动
set scrolloff=5
" 水平滚动
set sidescroll=1
set sidescrolloff=5

" =====搜索=====

" 高亮显示搜索结果
set hlsearch
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
set smartcase

" =====缩进=====

" 退格键正常处理
set backspace=2
" 智能缩进
"set cindent
" 自动缩进
set autoindent
" 制表符占用空格数
set tabstop=4
" 自动缩进距离
set shiftwidth=4
" 连续空格视为制表符
"set softtabstop=4
" 按退格键一次删掉4个空格
set smarttab
" 将Tab自动转化成空格
set ts=4
set expandtab
:%retab
" 智能缩进
"set shiftround
" 设置超过100长度提示
set colorcolumn=81
" 快捷键延迟
set ttimeoutlen=10
" 输入法正常切换
autocmd InsertLeave * if system('fcitx-remote') != 0 | call system('fcitx-remote -c') | endif

" 打开自动定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" 背景颜色
set background=dark
" 主题
let g:rehash256 = 1
let g:molokai_original = 1
set t_Co=256
"colorscheme molokai
colorscheme gruvbox
set redrawtime=10000
highlight Normal ctermbg=None

"设置鼠标选择
set mouse=a

"开启语法高亮
syntax on


" ===================== set keymapping =====================

" jk 替代 esc
inoremap jk <ESC>

" 定义<Leader>
let mapleader=";"

" 废弃快捷键
noremap <F1> <Nop>
inoremap <F1> <Nop>
nnoremap <Up> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Down> <Nop>

inoremap <Up> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Down> <Nop>

" 快速保存及退出
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>

" 调整窗口大小快捷键
nmap <C-W>= :resize +9<CR>
nmap <C-W>- :resize -9<CR>
nmap <C-W>, :vertical resize -9<CR>
nmap <C-W>. :vertical resize +9<CR>

" 命令行模式增强
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" 搜索关键词居中
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> <C-o> <C-o>zz
nnoremap <silent> <C-i> <C-i>zz

nnoremap <silent><Leader><Leader> :nohlsearch<CR>

" * 搜索不移动 可视模式高亮选中
function! Starsearch_CWord()
    let wordStr = expand("<cword>")
    if strlen(wordStr) == 0 | return | endif
    if wordStr[0] =~ '\<'
        let @/ = '\<' . wordStr . '\>'
    else
        let @/ = wordStr
    endif
    let savedS = @s
    normal! "syiw
    let @s = savedS
    set hlsearch
endfunction

function! Starsearch_VWord()
    let savedS = @s
    normal! gv"sy
    let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
    let @s = savedS
    set hlsearch
endfunction

nnoremap <silent> * :set nohlsearch\|:call Starsearch_CWord()<CR>
vnoremap <silent> * :<C-u>set nohlsearch\|:call Starsearch_VWord()<CR>

" 调整缩进后自动选中
vnoremap < <gv
vnoremap > >gv

" w!!用sudo保存
cabbrev w!! w !sudo tee > /dev/null %

" 关闭当前buf外的其他buf
nnoremap <Leader>bco :%bd \| e # \| bd #<CR>

"打开quickfix
nmap qf :copen<cr>
nmap q[ :cnext<cr>
nmap q] :cprevious<cr>

" =====FZF=====
" 设置搜索快捷键
" 搜索文件名
nnoremap <silent> <Leader>f :Files<CR>
" 光标所在词文件名搜索
nnoremap <silent> <Leader>F :call fzf#vim#files('.', {'options':'--query '.expand('<cword>')})<CR>
" 当前buffers 搜搜
nnoremap <silent> <leader>b :Buffers<CR>
" 光标所在词 当前打开buffer搜索
nnoremap <silent> <Leader>B :Buffers <C-R><C-W><CR>
" 模糊搜索
nnoremap <silent> <Leader>a :Ag<CR>
" 光标所在词模糊搜索
nnoremap <silent> <Leader>A :Agc<CR>

" =====EasyMotion=====
" f键快速跳转
map f <Plug>(easymotion-s)
map F <Plug>(easymotion-overwin-f)
" 关闭默认快捷键
let g:EasyMotion_do_mapping = 0
" 忽略大小写
let g:EasyMotion_smartcase = 1
" 跳转键
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'

" =====Airline=====
nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9

" =====vim-smooth-scroll=====
nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
nnoremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
nnoremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

"autocmd BufNewFile *.sh exec ":call AutoSetFileHead()"
augroup FileIndent
    autocmd!
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType yaml set tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead *.css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd BufRead *.json setlocal ts=2 sts=2 sw=2 expandtab
augroup END

" ===================== customize-common-package =====================

" =====Airline=====
" 设置airline主题
" let g:airline_theme="minimalist"
let g:airline_theme="base16"
let g:airline_powerline_fonts = 1
" 打开tabline功能
    "  是否airline显示
let g:airline#extensions#ale#enabled=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1

" 标签页只显示文件名
let g:airline#extensions#tabline#fnamemod = ':t'
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
" 去除右上角buffer
let g:airline#extensions#tabline#buffers_label = ''
" 标签页快捷键
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
            \ '0': '0: ', '1': '1: ', '2': '2: ', '3': '3: ', '4': '4: ',
            \ '5': '5: ', '6': '6: ', '7': '7: ', '8': '8: ', '9': '9: '
            \}

" =====FZF=====
command! -bang -nargs=* Agc
            \ call fzf#vim#ag(expand('<cword>'))
command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>,
            \                 <bang>0 ? fzf#vim#with_preview('up:60%')
            \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
            \                 <bang>0)

" fzf搜索结果分屏展示
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }


" tpope/vim-fugitive
"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>


" ===================== load-common-package =====================

" 视觉效果 -> 中文文档 
packadd vimcdoc " yianwillis/vimcdoc

"set rtp+=/usr/local/powerline/powerline/bindings/vim
" 位移效果 -> 模糊搜索 
set rtp+=~/.fzf
packadd fzf.vim

" airline  
packadd vim-airline        " vim-airline/vim-airline
packadd vim-airline-themes " vim-airline/vim-airline-themes

" 位移效果 -> 快速跳转到指定字母 
packadd vim-easymotion " TODO 有升级内容，有空可以更新一下使用方式

" 视觉效果 -> 主题配色
packadd gruvbox

" 视觉效果 -> 平滑滚动插件
packadd vim-smooth-scroll

" tpope/vim-fugitive
packadd vim-fugitive

call ccplugin#LoadCodeCommonPlugin()

nnoremap <Leader>hi :call go#goplugin#SetGolangHeader() <cr>
nnoremap <Leader>hu :call go#goplugin#UpdateGolangHeader() <cr>


nnoremap <leader>fm :call go#goplugin#GoFormat() <CR>
