echom "ftplugin sh"
call ccplugin#LoadCodeCommonPlugin()
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh' | call setline(1, "\#!/bin/bash") | endif
    normal G
    normal o
    normal o
endfunc
