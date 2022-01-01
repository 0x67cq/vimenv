nnoremap <leader>fm :call go#goplugin#GoFormat() <CR>

"packadd YouCompleteMe

" =====YCM=====

"let g:ycm_complete_in_comments=1
"let g:ycm_complete_in_strings=0
""let g:ycm_collect_identifiers_from_comments_and_strings=1
"let g:ycm_collect_identifiers_from_tags_files=1
"" 语法关键字补全
"let g:ycm_seed_identifiers_with_syntax = 1
"" 每次不同的vimrc之间更换需要手动指定/Users/guanchengqi/
"let g:ycm_global_ycm_extra_conf ="~/.vim/pack/code_common/opt/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py"

"" 关闭c语法检查
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_key_invoke_completion = '<C-z>'
"let g:ycm_min_num_identifier_candidate_chars = 2
"" c头文件识别
"let g:c_syntax_for_h = 1
"" 智能补全
""let g:ycm_semantic_triggers =  {
""            \   'c': ['->', '.', 're![a-zA-Z_][a-zA-Z_0-9]{2,}'],
""            \   'python,javascript,go': ['.', 're![a-zA-Z_][a-zA-Z_0-9]{2,}'],
""            \   'html': ['<', '"', '</', ' '],
""            \   'vim': ['re![_a-za-z]+[_\w]*\.'],
""            \   'css': ['re!^\s{2,4}', 're!:\s+' ],
""            \ }
""
""ycm 智能提醒触发补全
"let g:ycm_semantic_triggers =  {
"            \   'c,python,go': ['re!\w{2}'],
"            \   'javascript': ['re!\w{1}'],
"            \   'html': ['<', '"', '</', ' '],
"            \   'css': ['re!^\s{2,4}', 're!:\s+' ],
"            \   'vim': ['re![_a-za-z]+[_\w]*\.'],
"            \ }
""
""
"" 函数跳转
"nnoremap <leader>d :YcmCompleter GoTo<CR>
"" 纵向分屏跳转
"nnoremap <leader>v :vsplit \| YcmCompleter GoTo<CR>
"" 横向分屏跳转
"nnoremap <leader>s :split \| YcmCompleter GoTo<CR>

"nnoremap <leader>i :split \| YcmCompleter GoToImplementation<CR>


