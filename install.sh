#!/bin/bash
for x in .[[:alpha:]]*
do
   if [ -n $x -a "$x" != ".git" ]
   then
      rm -r "$HOME/$x"
      ln -s "`pwd`/$x" ~/
   fi
done

rm -rf ~/bin
ln -s "`pwd`/bin" ~/
