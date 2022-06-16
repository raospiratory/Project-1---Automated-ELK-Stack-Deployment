#! /bin/bash

#Creates 1000 login attempts on the web server 10.0.0.5.

for i in {1..1000};
 do
  ssh sysadmin@10.0.0.5;
 done


#Creates a nested loop that sends wget command on web servers 10.0.0.5, 10.0.0.6, 10.0.0.7. The loop will continue until you stop with CTRL+C.
while true;
 do
  for i in {5..7};
   do
    ssh sysadmin@10.0.0.$i;
   done;
 done


#Creates 1000 web requests on the web server 10.0.0.5 and 1000 downloaded files on your jump-box.
for i in {1..1000};
 do
  wget 10.0.0.5;
 done


#wget loop that creates a lot of duplicate files on your jump-box. Stop by doing CTRL+C.
while true;
 do 
  wget 10.0.0.5 -O /dev/null;
 done

#Creates a nested loop that sends wget command on web servers 10.0.0.5. 10.0.0.6, 10.0.0.7. The loop will continue until you stop with CTRL+C.
while true;
 do
  for i in {5..7};
   do
    wget -O /dev/null;
   done;
 done;
