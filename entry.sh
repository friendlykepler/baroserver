#!/bin/bash

cd ${STEAMAPPDIR}
rm serversettings.xml
cp ../serversettings.xml .
./DedicatedServer