# vimenv
my .vim &amp; .vimrc

依赖于 Vim8 的 pack 机制
自己写了一个类似于 vim-plug 的工具用于自动化下载&管理依赖

## 使用方法
将本仓库下载到 ~目录 并且命名为.vim 目录
git clone https://github.com/psychix/vimenv.git ~/.vim

如果使用的目的是golang开发

cd ~/.vim
git checkout purego

然后执行
cd ~/.vim/pvkeeper
go run pvk.go pvkmodel.go
(需要有go 1.11以上环境并且开启gomod)
如果是mac的话也可以执行二进制命令: pvkeeper

最后
打开vim 执行 :GoInstallBinaries 安装go的bin

执行完以上的步骤， 就可以无缝的进行golang的开发了。可能需要处于翻墙环境。不然emmmm不说了

## 定制化
对插件有定制化需求的话，可以修改pvkeeper下的pvk.yaml 

vimrc有修改需求的话，可以修改本目录下的vimrc

## pvk语法
```
version: "v0.1"
dependences:
  - plugin:
     name: "vimcdoc"
     desc: " 中文doc"
     url: "https://github.com/yianwillis/vimcdoc.git"
     locater: "~/.vim/pack/common/opt"
     tag: ""
     install: ""
```

每个plugin都是一个插件， name，desc， url， 分别是名字，描述，下载路径（必须为git）
locater是存放在本地的路径，git clone使用时会被拼接为 locater/name
tag 是git commit的hash或者tag， 可以指定某个版本。
install是下载完成之后的安装命令。比如像ycm那样的插件，但是如果是像fzf那样的需要交互确认的插件还是需要手动执行的

## 更新到指定版本功能&从现有环境下生成pvk的功能 还在开发中
