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
    let g:airline#extensions#branch#enabled=1

    
" ===================== load-package =====================
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

" 打开错误面板
"function! ccplugin#ToggleErrors()
"    normal ;zz
"    let old_last_winnr = winnr('$')
"    lclose
"    if old_last_winnr == winnr('$') | lwindow | endif
"endfunction



