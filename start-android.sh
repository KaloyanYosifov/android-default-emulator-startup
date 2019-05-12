#! /bin/bash

abdLocation=$(which adb 2> /dev/null)

if [ -z $abdLocation ]; then
    echo "Please install Android Studio or (add platform-tools to your \$PATH environement)!"
    exit 0
fi