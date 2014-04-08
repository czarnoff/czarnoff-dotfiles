reset
echo trying jawmark
until ssh -t jeffery@jawmarkinside.homeip.net  screen -xR
do
   sleep 15
   echo -n trying jawmark
   date
done

