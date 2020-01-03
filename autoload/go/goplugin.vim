" ======= golang plugin loading ========
function! SetGolangHeader()
        call setline("1", "/****************************************************")
        call append("1", "**                                                 **")
        call append("2", "**       Author:     guanchengqi                   **")
        call append("3", "**       Email:      guancq@tuya.com               **")
        let r = strftime("**       CreateTime: 20%y.%m.%d(%A)          **")
        call append("4", r)
        let rs = strftime("**       UpdateTime: 20%y.%m.%d(%A)          **")
        call append("5", rs)
        call append("6", "**                                                 **")
        call append("7", "****************************************************/")
endfunction
function! UpdateGolangHeader()
    if &readonly
       return
    endif
    let l6 = split(getline("6"), '\zs', 1)
    if l6[1] == "*"
        let rs = strftime("**       UpdateTime: 20%y.%m.%d(%A)            **")
        call setline("6", rs)
    else 
        let l1=getline("1")
        call setline("1", "/****************************************************")
        call append("1", "**                                                 **")
        call append("2", "**       Editor:     guanchengqi                   **")
        call append("3", "**       Email:      guancq@tuya.com               **")
        let rs = strftime("**       UpdateTime: 20%y.%m.%d(%A)           **")
        call append("4", rs)
        call append("5", "**                                                 **")
        call append("6", "****************************************************/")
        call append("7", "")
        call append("8",l1)
    endif
endfunction

" 自动添加头部
function! go#goplugin#LoadGoPlugin()
    if exists('g:golang_loaded')
        finish
    endif
    let g:golang_loaded = 1
    call ccplugin#LoadCodeCommonPlugin()
" 函数跳转
    nnoremap <leader>y :GoDef<CR>
    " 纵向分屏跳转
    nnoremap <leader>v :vsplit \| GoDef<CR>
    " 横向分屏跳转
    nnoremap <leader>s :split \| GoDef<CR>


    nnoremap <Leader>hi :call SetGolangHeader() <cr>
    nnoremap <Leader>hu :call UpdateGolangHeader() <cr>
    " =================vim-go====================
    "
    let g:go_highlight_functions = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_function_parameters = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_types = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_string_spellcheck = 1
    let g:go_highlight_format_strings = 1
    let g:go_highlight_variable_declarations = 1
    let g:go_highlight_variable_assignments = 1
    let g:go_highlight_array_whitespace_error = 1
    let g:go_highlight_chan_whitespace_error = 1
    let g:go_decls_includes = "func,type"
    let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
    nnoremap <leader>rr :GoRun<cr>
    nnoremap <leader>dc :GoDoc<cr>
    nnoremap <leader>e  :GoVet<cr>
    nnoremap <leader>ft :GoFmt<cr>
    nnoremap <leader>tt :GoTest<cr>

    packadd vim-go
endfunction


