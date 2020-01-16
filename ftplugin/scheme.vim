echom "ftplguin scheme"
call ccplugin#LoadCodeCommonPlugin()

"===========scheme repl函数=============
"vim-slime

function SchemeStart()
    "only if the buffer is a scheme file and no terminal exists
    if &filetype == "scheme" && len(term_list()) == 0
        "only start once
        autocmd! SchemeREPL *
        augroup! SchemeREPL

        "get original buffer number
        let original_bufnr = win_getid()
        "start the terminal, with scheme running
        let term_bufnr = term_start('scheme', {"term_finish": "close"})
        "get back to the original buffer
        call win_gotoid(original_bufnr)

        "no vim-slime menus
        if !exists("b:slime_config")
            let b:slime_config = {"bufnr": ""}
        endif
        let b:slime_config["bufnr"] = term_bufnr
    endif
endfunction

function SchemeSetUp()
    "everytime a new buffer is read, try to start REPL
    augroup SchemeREPL
        autocmd BufRead * :call SchemeStart()
    augroup END
    "the time when vim is ready
    call SchemeStart()
endfunction

augroup SchemeREPL
    au!
    let g:slime_target = "vimterminal"
    packadd vim-slime
    "when vim is ready, start the script
    autocmd VimEnter * :call SchemeSetUp()
augroup END
