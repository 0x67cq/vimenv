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

nnoremap <Leader>hi :call SetGolangHeader() <cr>
nnoremap <Leader>hu :call UpdateGolangHeader() <cr>
