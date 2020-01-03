function! ccplugin#LoadCodeCommonPlugin()
    if exists('g:code_common_loaded')
        return 
    endif
    let g:code_common_loaded = 1
    "echom "loading ccplugin#LoadCodeCommonPlugin"
     
    " 开启彩虹括号
    let g:rainbow_active = 1

    " =====Nerdcommenter=====
    " 关闭默认快捷键
    let g:NERDCreateDefaultMappings = 0
    " 注释符左对齐
    let g:NERDDefaultAlign = 'left'
    " 自动注释快捷键
    map <C-_> <plug>NERDCommenterToggle

    " =====YCM=====

    "let g:ycm_min_num_of_chars_for_completion=1
    "let g:ycm_min_num_identifier_candidate_chars=0
    let g:ycm_complete_in_comments=1
    let g:ycm_complete_in_strings=0
    "let g:ycm_collect_identifiers_from_comments_and_strings=1
    let g:ycm_collect_identifiers_from_tags_files=1
    " 语法关键字补全
    let g:ycm_seed_identifiers_with_syntax = 1
    " 每次不同的vimrc之间更换需要手动指定
    let g:ycm_global_ycm_extra_conf ="/Users/guancq/.vim/pack/code_common/opt/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py"
    
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
                \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                \ 'cs,lua,javascript': ['re!\w{1}'],
                \ }
    " 函数跳转
    nnoremap <leader>y :YcmCompleter GoTo<CR>
    " 纵向分屏跳转
    nnoremap <leader>v :vsplit \| YcmCompleter GoTo<CR>
    " 横向分屏跳转
    nnoremap <leader>s :split \| YcmCompleter GoTo<CR>


" ===================== load-package =====================
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

