#!/bin/bash

source './.env'

if [ -z "$REMOTE_HOST" ]; then
        echo " - REMOTE_HOST Environment Variable should be set in .env file"
        exit
fi
if [ -z "$CALLERID" ]; then
        echo " - CALLERID Environment Variable should be set in .env file"
        exit
fi
if [ -z "$USERNAME" ]; then
        echo " - USERNAME Environment Variable should be set in .env file"
        exit
fi


usage() {
  echo "USAGE:"
  echo "sipp-run.sh [CONCURRENTCALLS] [CPS]"
}

CONCURRENTCALLS=$1
CPS=$2
if [ -z "$CONCURRENTCALLS" ]; then
  usage
  exit
fi
if [ -z "$CPS" ]; then
  usage
  exit
fi

let DURATION=CONCURRENTCALLS/CPS
RATE_PERIOD=`python -c "print 1.0 / $CPS"`
if [ -z "$DURATION" ]; then
  usage
  exit
fi
if [ -z "$RATE_PERIOD" ]; then
  usage
  exit
fi

echo sipp -sf uac.xml $REMOTE_HOST -r 1 -rp ${RATE_PERIOD}s -l $CONCURRENTCALLS -d ${DURATION}s -s $USERNAME -key callerid $CALLERID -rtp_echo  
sipp -sf uac.xml $REMOTE_HOST -r 1 -rp ${RATE_PERIOD}s -l $CONCURRENTCALLS -d ${DURATION}s -s $USERNAME -key callerid $CALLERID -rtp_echo  

