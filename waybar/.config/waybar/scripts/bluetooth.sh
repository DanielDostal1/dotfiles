#!/bin/bash

if bluetoothctl show | grep -q "Powered: yes"; then
    if bluetoothctl devices Connected | grep -q "Device"; then
        echo " Connected"
    else
        echo " On"
    fi
else
    echo " Off"
fi
