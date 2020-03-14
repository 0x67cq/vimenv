# vimenv
my .vim &amp; .vimrc

依赖于 Vim8 的 pack 机制
自己写了一个类似于 vim-plug 的工具用于自动化下载&管理依赖

使用这个主要需要掌握的前置知识点

## Vim scripts loading order Vim 启动流
vim 在启动的时候，会从一个记载着所有需要去处理的初始化path runtimepath|rtp
详细介绍可以查阅  :h rtp
vim-plug 的方式就是这个，每个插件作为一个独立的.vim，然后把每个插件的地址都放入到rtp中。

vim 的默认加载文件夹构成: ls ~/.vim/ **通过使用 set rtp+=path 来定制vim脚本预加载位置**
```shell
drwxr-xr-x   9 guancq  staff   288 12 25 15:03 after    # 在执行ft,plugin之后会执行的脚本位置
drwxr-xr-x   3 guancq  staff    96 12 25 15:03 autoload # 懒加载命令脚本
drwxr-xr-x   3 guancq  staff    96 12 25 15:03 colors   # :colorscheme gruvbox 触发配色
drwxr-xr-x   3 guancq  staff    96 12 25 15:03 compiler # :compiler 触发
drwxr-xr-x   4 guancq  staff   128 12 25 15:25 ftdetect # :检查文件类型 可以利用这个特性进行懒加载
drwxr-xr-x   4 guancq  staff   128 12 25 15:47 ftplugin # :只执行文件类型同名的.vim脚本
drwxr-xr-x   3 guancq  staff    96 12 25 15:03 indent   # :缩进，需要开启
drwxr-xr-x   3 guancq  staff    96 12 25 15:03 plugin   # :总是执行该文件夹下的*.vim
drwxr-xr-x   3 guancq  staff    96 12 25 15:03 syntax   # :语法
```
vim 的**默认启动流**:
1. vimrc
2. plugin/*.vim
3. after/plugin/*.vim

**When vimrc set `filetype on`, Vim started** 
**注意，是所有&rtp 的路径的 2（ftdetect），3（after/ftdetect)，4，5这样跑**

1. .vimrc 
2. ftdetect/*.vim 
3. after/ftdetect/*.vim 
4. plugin/*.vim 
5. after/plugin/*.vim

**When vimrc set `filetype plugin on`, Vim started** 

1. .vimrc 
2. ftdetect/*.vim 
3. after/ftdetect/*.vim 
4. ftplugin/*.vim 
5. plugin/*.vim 
6. after/plugin/*.vim

**When `set filetype=foobar`**

1. ftplugin/foobar.vim 
1. after/ftplugin/foobar.vim 
1. indent/foobar.vim   `filetype indent on`
1. after/indent/foobar.vim 
1. syntax/foobar.vim 
1. after/syntax/foobar.vim

**When `call foo#bar#hello_world()`**

1.  autoload/foo/bar.vim

**NOTE: autoload never check after/ folders**

**When `:compiler foobar`**

1. compiler/foobar.vim
1. after/compiler/foobar.vim

**When `:colorscheme foobar`**

1. colors/foobar.vim 

**When `:colorscheme foobar` with exvim/ex_aftercolors installed**

1. colors/foobar.vim 
1. after/colors/foobar.vim




## vim8 的pack机制
两个特殊目录：
$eachrtp/pack/*/start/*(插件目录) start 是在vim启动时会自动加载的目录，start 下所有的文件夹都会被加载到 rtp 中进行插件的加载
$eachrtp/pack/*/opt/*(插件目录) opt 是在vim启动时不会自动加载的目录，opt 下所有的文件夹只有在vimL执行 packadd 命令的时候会去搜索并执行

### package概念
Vim 启动时，处理完 .vimrc 后，扫描'packpath'里的所有目录，寻找"each$packpath/pack/*/start"目录里的目录。把这些目录加入'runtimepath'，然后载入所有插件。 （加入runtimepath之后，就和开始的加载逻辑一致了）

### packadd 命令
:packadd XXX
在执行packadd的时候，vim会去扫描'packpath'里的所有目录，寻找"each$packpath/pack/\*/opt"目录下的名为XXX的目录，找到 '$packpath/pack/\*/opt/XXX'目录后， 执行'$packpath/pack/\*/opt/XXX/plugin/*.vim'
