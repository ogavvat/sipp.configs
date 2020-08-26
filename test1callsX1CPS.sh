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
if [ -z "$SERVICE" ]; then
        echo " - SERVICE Environment Variable should be set in .env file"
        exit
fi

sipp -sf uac.xml $REMOTE_HOST -r 1  -rp 0.1s -l 1 -d 1s -s $SERVICE -key callerid $CALLERID -rtp_echo  

