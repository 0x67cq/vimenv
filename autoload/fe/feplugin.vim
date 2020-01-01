" ======= FE plugin loading ========
function! fe#feplugin#LoadFEPlugin()
    if exists('g:front_end_loaded')
        finish
    endif
    let g:front_end_loaded = 1
    call ccplugin#LoadCodeCommonPlugin()
    echom "loading fe#feplugin#LoadFEPlugin"
    let g:jsx_ext_required = 1
    let g:jsx_pragma_required = 1
    packadd vim-javascript
    packadd vim-jsx

    packadd vim-css3-syntax
    packadd emmet-vim
    packadd typescript-vim
    packadd vim-prettier
    packadd html5.vim

endfunction

