wget -q http://www.duke-energy.com/indiana/outages/current.asp -O - | grep -A 2 -i monroe | tail -n 1 | cut -d\> -f2 | cut -d\< -f1 | sed s/,// >> ~/power_out
echo ~/power_out
while sleep 299
do 
   wget -q http://www.duke-energy.com/indiana/outages/current.asp -O - | grep -A 2 -i monroe | tail -n 1 | cut -d\> -f2 | cut -d\< -f1 | sed s/,// >> ~/power_out
   tail -n 1 ~/power_out
   date
done
