#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Invalid usage cwa <ip>"
  exit 1
fi

ip=$1

adb tcpip 5555
adb connect "${ip}:5555"
