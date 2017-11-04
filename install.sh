#!/bin/bash
git submodule init
git submodule update
#git submodule foreach git pull origin master

curl -s "https://get.sdkman.io" | bash

for x in .[[:alpha:]]*
do
   if [ -n $x -a "$x" != ".git" ]
   then
      rm -r "$HOME/$x"
      ln -s "`pwd`/$x" ~/
   fi
done

pushd .
cd config
for x in *
do
   if [ -n $x -a "$x" != ".git" ]
   then
      echo $x
      rm -rf "$HOME/.config/$x"
      ln -s "`pwd`/$x" ~/.config/
   fi
done

popd

rm -rf ~/bin
ln -s "`pwd`/bin" ~/
rm -rf ~/.oh-my-zsh
ln -s "`pwd`/oh-my-zsh" ~/.oh-my-zsh

#sudo pip3 install pywal
#sudo pip3 install wal-steam
