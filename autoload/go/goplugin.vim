" ======= golang plugin loading ========
function! go#goplugin#SetGolangHeader()
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
function! go#goplugin#UpdateGolangHeader()
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
    nnoremap <leader>d :GoDef<CR>
    " 纵向分屏跳转
    nnoremap <leader>v :vsplit \| GoDef<CR>
    " 横向分屏跳转
    nnoremap <leader>s :split \| GoDef<CR>
endfunction


nnoremap <Leader>hi :call go#goplugin#SetGolangHeader() <cr>
nnoremap <Leader>hu :call go#goplugin#UpdateGolangHeader() <cr>
" =================vim-go====================
"
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
      let l:file = expand('%')
      if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
      elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
      endif
endfunction
    
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

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
"nnoremap <leader>e  :GoVet<cr>

"augroup go
"    au!
"    au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
"    au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
"    au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
"    au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

"    au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
"    au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
"    au FileType go nmap <Leader>db <Plug>(go-doc-browser)

"    au FileType go nmap <leader>r  <Plug>(go-run)
"    au FileType go nmap <leader>t  <Plug>(go-test)
"    au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
"    au FileType go nmap <Leader>i <Plug>(go-info)
"    au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
"    au FileType go nmap <C-g> :GoDecls<cr>
"    au FileType go nmap <leader>dr :GoDeclsDir<cr>
"    au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
"    au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
"    au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>
"augroup END

inoremap .. <C-x><C-o>

packadd vim-go


