" ======= FE plugin loading ========
function! fe#feplugin#LoadFEPlugin()
    if exists('g:front_end_loaded')
        finish
    endif
    let g:front_end_loaded = 1
    echom "loading fe#feplugin#LoadFEPlugin"

endfunction

