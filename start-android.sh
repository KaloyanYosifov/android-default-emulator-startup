#! /bin/bash

checkIfbinaryExists()
{
    # get the binary location
    # and send the errors (2>) to null
    binaryLocation=$(which $1 2> /dev/null)
    
    if [ -z $binaryLocation ]; then
        echo "$2"
        exit 0
    fi
}

# get the lcoation of abd binary of android studio
checkIfbinaryExists "android" "Please install Android Studio!"

android=$(which android)
