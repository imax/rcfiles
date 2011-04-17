#!/bin/bash
# Installation on a clean machine

destdir=$HOME   # install to $HOME by default, override with HOME=...  install.sh
cd `dirname $0` # chdir to where the files are
here=`pwd`

function link() {
  dest=$destdir/$1
  [ -L $dest ] && { echo "skip $dest"; return; }
  [ -f $dest -o -d $dest ] && { echo "already exists: $dest" ; return; }
  [ -e $dest ] || { ln -vs $here/$1 `dirname $dest` ; }
}

for name in `find . -maxdepth 1 -not -name bin -not -iname .hg \
  -not -name .ssh -not -iname install.sh -not -name . -not -name .hgignore`
do
  link $name
done

[ -d ~/.ssh ] || { mkdir ~/.ssh && chmod 700 ~/.ssh; }
link .ssh/config

[ -d ~/bin ] || { mkdir ~/bin; }
for name in `find bin -maxdepth 1 -not -name bin`
do
  link $name
done

# OLD: plain tar/cp
# tar cvf - . --exclude=.hg --exclude=install.sh  | (cd $destdir && tar xf -)
