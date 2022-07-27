#!/bin/bash
export INSTANA_AGENT_KEY="Y1WeVUl6klDiPi3WPtqBMv"

# Build 
echo start build
sudo docker-compose build

# Deploy
echo start up
#sudo nohup docker compose up >/dev/null 2>&1 &
sudo docker-compose up
echo "finish start up"

# Send request with time and version to Instana
line=`cat .env |head -n 3|tail -n 1`
version=${line: 4}
current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s`
Date=`date "+%N"`
currentTimeStamp=$((timeStamp*1000+$((10#$Date))/1000000))
curl -X POST https://168.1.53.208/api/releases -H "Authorization: apiToken hyTT9rt3RQWwrHJja_aTDw" -H "Content-Type: application/json" -d '{"name": "'${version}'", "start": '${currentTimeStamp}', "applications": [{"name": "robot-shop-ce"}]}' -k
