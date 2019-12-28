function! py#pyplugin#LoadPYPlugin()
    if exists('g:python_loaded')
        finish
    endif
    let g:python_loaded = 1
    echom "loading py#pyplugin#LoadPYPlugin"
    " Chiel92/vim-autoformat
endfunction




