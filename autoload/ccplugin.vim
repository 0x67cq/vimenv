" 打开错误面板
nnoremap <Leader>e :call ccplugin#ToggleErrors()<cr>
function! ccplugin#ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$') | lwindow | endif
endfunction

function! ccplugin#LoadCodeCommonPlugin()
    if exists('g:code_common_loaded')
        return 
    endif
    let g:code_common_loaded = 1
     
    " 开启彩虹括号
    let g:rainbow_active = 1

    " =====Nerdcommenter=====
    " 关闭默认快捷键
    let g:NERDCreateDefaultMappings = 0
    " 注释符左对齐
    let g:NERDDefaultAlign = 'left'
    " 自动注释快捷键
    map <C-_> <plug>NERDCommenterToggle

    " =========ale==========
    "  是否airline显示
    let g:ale_linters = {
                \ 'python': ['flake8'], 
                \'javascript': ['eslint'], 
                \'c': ['clang'],
                \'go': ['gopls'], 
                \}
    " golangci-lint
    let g:airline#extensions#hunks#enabled=0
    let g:airline#extensions#branch#enabled=1
    let g:airline#extensions#ale#enabled=1
    " 关闭自动检查
    let g:ale_lint_on_text_changed = 0
    " 提示符修改
    " 设置错误符号
    let g:ale_sign_error='✗'
    " 设置警告符号
    let g:ale_sign_warning='⚠'
    " 是否在打开文件时检查
    let g:syntastic_check_on_open=0
    " 是否在保存文件后检查
    let g:syntastic_check_on_wq=1
    " 显示侧边栏
    let g:ale_sign_column_always = 1
    " 改变状态栏信息格式
    let g:ale_statusline_format = ['✗ %d', '⚠ %d', '✔ ok']
    " 改变命令行信息
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    " 打开关闭 错误提示pane

    " =====YCM=====

    let g:ycm_complete_in_comments=1
    let g:ycm_complete_in_strings=0
    "let g:ycm_collect_identifiers_from_comments_and_strings=1
    let g:ycm_collect_identifiers_from_tags_files=1
    " 语法关键字补全
    let g:ycm_seed_identifiers_with_syntax = 1
    " 每次不同的vimrc之间更换需要手动指定
    let g:ycm_global_ycm_extra_conf ="/Users/guanchengqi/.vim/pack/code_common/opt/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py"
    
    " 关闭c语法检查
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_key_invoke_completion = '<C-z>'
    let g:ycm_min_num_identifier_candidate_chars = 2
    " c头文件识别
    let g:c_syntax_for_h = 1
    " 智能补全
    "let g:ycm_semantic_triggers =  {
    "            \   'c': ['->', '.', 're![a-zA-Z_][a-zA-Z_0-9]{2,}'],
    "            \   'python,javascript,go': ['.', 're![a-zA-Z_][a-zA-Z_0-9]{2,}'],
    "            \   'html': ['<', '"', '</', ' '],
    "            \   'vim': ['re![_a-za-z]+[_\w]*\.'],
    "            \   'css': ['re!^\s{2,4}', 're!:\s+' ],
    "            \ }
    "
    "ycm 智能提醒触发补全
    let g:ycm_semantic_triggers =  {
                \ 'c,python,go,perl': ['re!\w{2}'],
                \ 'lua,javascript': ['re!\w{1}'],
                \ }
    " 函数跳转
    nnoremap <leader>y :YcmCompleter GoTo<CR>
    " 纵向分屏跳转
    nnoremap <leader>v :vsplit \| YcmCompleter GoTo<CR>
    " 横向分屏跳转
    nnoremap <leader>s :split \| YcmCompleter GoTo<CR>


" ===================== load-package =====================
    " ale
    packadd ale
    " Valloric/YouCompleteMe  { 'do': 'python3 install.py  --ts-completer --go-completer --clang-completer' }
    packadd YouCompleteMe
    " scrooloose/nerdcommenter
    packadd nerdcommenter
    "  https://github.com/jiangmiao/auto-pairs.git
    packadd auto-pairs
    " luochen1990/rainbow
    packadd rainbow
    "
    " vim-scripts/AnsiEsc.vim
    " packadd AnsiEsc.vim
    " SirVer/ultisnips
    " honza/vim-snippets
    " scrooloose/nerdtree
    " packadd nerdtree
    " majutsushi/tagbar   brew install ctags gtags
    " packadd tagbar
    " tpope/vim-surround
    " packadd tagbar
    " jpalardy/vim-slime
    " packadd vim-slime
endfunction

