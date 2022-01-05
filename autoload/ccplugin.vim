" 打开错误面板
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
                \'c': ['clang'],
                \'go': ['gopls'], 
                \'python': ['autopep8'],
                \'javascript': ['eslint'],
                \}
    " airline 显示
    let g:airline#extensions#hunks#enabled=0
    let g:airline#extensions#branch#enabled=1
    let g:airline#extensions#ale#enabled=1
    " 提示符修改
    " 设置错误符号
    let g:ale_sign_error='✗'
    " 设置警告符号
    let g:ale_sign_warning='⚠'
    " 关闭文件变动时自动检查
    let g:ale_lint_on_text_changed = 0
    " 是否在文件修改的时候检查
    let g:ale_completion_enabled = 0
    " 显示侧边栏
    let g:ale_sign_column_always=1
    " 改变状态栏信息格式
    let g:ale_statusline_format = ['✗ %d', '⚠ %d', '✔ ok']
    " 改变命令行信息
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    " 打开关闭 错误提示pane
    nnoremap <Leader>e :call ccplugin#ToggleErrors()<cr>
    "
    "

    " vim-lsp
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

    "" 函数跳转
    nnoremap <leader>d :LspDefinition<CR>
    " 纵向分屏跳转
    nnoremap <leader>v :vsplit \| LspDefinition<CR>
    " 横向分屏跳转
    nnoremap <leader>s :split \| LspDefinition<CR>
    
    nnoremap <leader>i :split \| LspImplementation<CR>

    " pip3 install python-language-server
    if executable('pyls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ })
    endif
    " npm i -g bash-language-server
    if executable('bash-language-server')
      au User lsp_setup call lsp#register_server({
            \ 'name': 'bash-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
            \ 'whitelist': ['sh', 'bash'],
            \ })
    endif
    " OSX xcrun --find clangd
    if executable('/Library/Developer/CommandLineTools/usr/bin/clangd')
      au User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['/Library/Developer/CommandLineTools/usr/bin/clangd']},
            \ 'whitelist': ['c'],
            \ })
    endif
    " GO111MODULE=on go install -v gopls
    if executable('gopls')
      au User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls']},
            \ 'whitelist': ['go'],
            \ })
    endif
    " npm i -g vscode-html-languageserver-bin
    " npm i -g vscode-langservers-extracted
    " hrsh7th/vim-vsnip
    " hrsh7th/vim-vsnip-integ
    if executable('html-languageserver')
      au User lsp_setup call lsp#register_server({
            \ 'name': 'html-languageserver',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
            \ 'whitelist': ['css', 'js', 'html', 'ts'],
            \ })
    endif
    " npm i -g vscode-css-languageserver-bin
    if executable('css-languageserver')
      au User lsp_setup call lsp#register_server({
            \ 'name': 'css-languageserver',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
            \ 'whitelist': ['css', 'js', 'html', 'ts'],
            \ })
    endif
    " npm i -g typescript-language-server
    if executable('typescript-language-server')
    	autocmd User lsp_setup call lsp#register_server({
    		\ 'name': 'typescript-language-server',
    		\ 'cmd': {server_info->[
    			\ &shell,
    			\ &shellcmdflag,
    			\ 'typescript-language-server --stdio',
    		\ ]},
    		\ 'root_uri': {server_info->lsp#utils#path_to_uri(
    			\ lsp#utils#find_nearest_parent_file_directory(
    				\ lsp#utils#get_buffer_path(),
    				\ ['tsconfig.json', 'package.json']
    			\ )
    		\ )},
    		\ 'whitelist': ['javascript', 'typescript', 'typescriptreact'],
    	\ })
    endif
    " npm i -g dockerfile-language-server-nodejs
    if executable('docker-langserver')
      au User lsp_setup call lsp#register_server({
            \ 'name': 'docker-langserver',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
            \ 'whitelist': ['dockerfile'],
            \ })
    endif
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
        \ 'name': 'file',
        \ 'whitelist': ['*'],
        \ 'priority': 10,
        \ 'completor': function('asyncomplete#sources#file#completor')
        \ }))

    " npm i -g dockerfile-language-server-nodejs
    " npm i -g typescript-language-server
    " npm i -g vscode-css-languageserver-bin
    " npm i -g vscode-html-languageserver-bin
    " GO111MODULE=on go install -v gopls
    " npm i -g bash-language-server
    " pip3 install python-language-server
    " OSX xcrun --find clangd



" ================Tagbar============================
    nnoremap <leader>t :Tagbar<CR>

" ===================== load-package =====================
    " ale
    packadd ale
    " Valloric/YouCompleteMe  { 'do': 'python3 install.py  --ts-completer --go-completer --clang-completer' }
    "packadd YouCompleteMe
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
    " majutsushi/tagbar   brew install ctags |apt install  exuberant-ctags | go get -u github.com/jstemmer/gotags
    " exuberant-ctags
    packadd tagbar
    " tpope/vim-surround
    " packadd tagbar
    " jpalardy/vim-slime
    " packadd vim-slime
    "
    " LSP 
    packadd asyncomplete.vim
    packadd vim-lsp
    packadd asyncomplete-lsp.vim
    packadd asyncomplete-file.vim

    packadd vim-vsnip-integ
    packadd vim-vsnip

endfunction

