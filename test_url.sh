i=0
url=$1
while true
do
http_status=`curl -s -o /dev/null -w "%{http_code}" $url --connect-timeout 0 --max-time 1 --retry 0`
if [ $http_status -eq 200 ];then
    echo request $i - $http_status - OK
else
    echo request $i - ERROR
fi
sleep 0.5
i=$((i + 1))
done
