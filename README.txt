Installation:

    git clone git://github.com/jdiamond/dotvim.git ~/.vim

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

On Windows (as Administrator):

    cd %HOME%
    git clone git://github.com/jdiamond/dotvim.git .vim
    mklink .vim\vimrc .vimrc
    mklink .vim\gvimrc .gvimrc
    cd .vim
    git submodule init
    git submodule update

