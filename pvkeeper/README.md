自动化下载vim依赖工具

## Intro
将vim的依赖写在当前目录的pvk.yaml里,然后使用此工具可以自动化的将依赖下载到指定目录

然后根据vim8自带的包管理体系,只需要切换上层的分支,获得不同的vimrc,即可使用不同的vimrc进行开发

可以有效的加速vim，避免不必要的依赖导致的vim速度变慢。
并且提供了不同需求，动态使用不同的依赖的功能。



## Usage
go run pvk.go pvkmodel.go

需要go1.11之后的环境，并且开启了gomod

