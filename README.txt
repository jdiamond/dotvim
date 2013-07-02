## Mac OS X (maybe Unix-likes, too)

Clone the repository:

    git clone git://github.com/jdiamond/dotvim.git ~/.vim

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule update --init

Install configured bundles:

    vim +BundleInstall +qall

If that command doesn't work, launch vim, and run :BundleInstall.

## Windows

As Administrator (or mklink won't work):

    cd %HOME%
    git clone git://github.com/jdiamond/dotvim.git .vim
    mklink .vimrc .vim\vimrc
    mklink .gvimrc .vim\gvimrc
    cd .vim
    git submodule update --init
    vim +BundleInstall +qall

I think that mklink only runs on Vista and up. If you're on XP, you can create
a .vimrc with this one line in it in %HOME%.

    source ~/.vim/vimrc

Your .gvimrc could look like this:

    source ~/.vim/gvimrc

