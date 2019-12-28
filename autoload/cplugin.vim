" ======= clang plugin loading ========
function! cplugin#LoadCPlugin()
    if exists('g:clang_loaded')
        finish
    endif
    let g:clang_loaded = 1
    echom "loading cplugin#LoadCPlugin"
    " Chiel92/vim-autoformat
endfunction


