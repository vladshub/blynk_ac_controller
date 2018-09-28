#!/bin/bash

git clone https://github.com/blynkkk/blynk-library.git lib/blynk-library
cd lib/blynk-library
git pull
cd ../..

case "$1" in
raspberry)
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install build-essential git-core
    git clone git://git.drogon.net/wiringPi lib/wiringPi
    cd lib/wiringPi
    git pull origin
    ./build
    gpio -v
    cd ../..
    make clean all target=raspberry
    exit 0
    ;;
linux)
    make clean all
    exit 0
    ;;
esac

echo "Please specify platform: raspberry, linux"
exit 1
