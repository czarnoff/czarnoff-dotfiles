#!/bin/bash
until ssh -Xt jeffery@jawmarkinside.homeip.net screen -xR
do
   sleep 300
done
