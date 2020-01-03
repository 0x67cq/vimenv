#common_path = ~/.vim/pack/common/opt
echo "mkdir -p ~/.vim/pack/common/opt"
mkdir -p ~/.vim/pack/common/opt

echo "start install base plugin"
git clone https://github.com/yianwillis/vimcdoc.git  ~/.vim/pack/common/opt/vimcdoc
git clone https://github.com/terryma/vim-smooth-scroll ~/.vim/pack/common/opt/vim-smooth-scroll
git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/common/opt/gruvbox
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/common/opt/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/common/opt/vim-airline-themes
git clone https://github.com/easymotion/vim-easymotion.git ~/.vim/pack/common/opt/vim-easymotion
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
git clone https://github.com/junegunn/fzf.vim.git ~/.vim/pack/common/opt/fzf.vim
git clone https://github.com/tpope/vim-fugitive ~/.vim/pack/code_common/opt/vim-fugitive


#code_common_path = ~/.vim/pack/code_common/opt
echo "mkdir -p ~/.vim/pack/code_common/opt"
mkdir -p ~/.vim/pack/code_common/opt

git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/pack/code_common/opt/YouCompleteMe
cd ~/.vim/pack/code_common/opt/YouCompleteMe
git submodule update --init --recursive
python3 install.py  --go-completer --clang-completer

git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/pack/code_common/opt/nerdcommenter
git clone https://github.com/jiangmiao/auto-pairs.git ~/.vim/pack/code_common/opt/auto-pairs
git clone https://github.com/luochen1990/rainbow.git ~/.vim/pack/code_common/opt/rainbow

