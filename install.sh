#!/bin/bash
for x in .[a-Z]*
do
   if [ -n $x -a "$x" != ".git" ]
   then
      rm -r "$HOME/$x"
      ln -s "`pwd`/$x" ~/
   fi
done

rm -rf ~/bin
ln -s "`pwd`/bin" ~/
