#!/bin/bash
NUMBER_OF_INSTANCES=$1
MAVLINK_TCP_OUT=$2

python3 /usr/local/bin/mavproxy.py --daemon --master=udpin:127.0.0.1:14550 --out=tcpin:0.0.0.0:$MAVLINK_TCP_OUT 2>&1 > /dev/null &

cd PX4-Autopilot
HEADLESS=1 make px4_sitl_default 

cd Tools/
chmod +x sitl_multiple_run.sh
chmod +x jmavsim_run.sh

./sitl_multiple_run.sh ${NUMBER_OF_INSTANCES} &

#HEADLESS=1 /bin/bash jmavsim_run.sh -l &

END=$(( $NUMBER_OF_INSTANCES ))
for i in $(eval echo "{1..$END}")
do
    echo "Running Instance" $i "at tcp" $(echo $(( $i+4560-1 )))
    HEADLESS=1 /bin/bash jmavsim_run.sh -p $(echo $(( $i+4560-1 ))) -l &
done

echo script still running...
( trap exit SIGINT ; read -r -d '' _ </dev/tty ) ## wait for Ctrl-C
