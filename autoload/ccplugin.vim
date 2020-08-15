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
                \'go': ['gopls', 'golint'], 
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
    "let g:syntastic_check_on_open=0
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
     
    let g:airline#extensions#branch#enabled=1

    
" ===================== load-package =====================
    packadd ale
    " scrooloose/nerdcommenter
    packadd nerdcommenter
    "  https://github.com/jiangmiao/auto-pairs.git
    "packadd auto-pairs
    packadd delimitmate
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

" 打开错误面板
"function! ccplugin#ToggleErrors()
"    normal ;zz
"    let old_last_winnr = winnr('$')
"    lclose
"    if old_last_winnr == winnr('$') | lwindow | endif
"endfunction



