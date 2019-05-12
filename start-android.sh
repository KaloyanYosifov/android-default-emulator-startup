#! /bin/bash

abdLocation=$(which adb 2> /dev/null)

if [ -z $abdLocation ]; then
    echo "Please install Android Studio or (set the path to )"
fi