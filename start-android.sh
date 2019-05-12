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

# get the location of android
checkIfbinaryExists "android" "Please install Android Studio!"

android=$(which android)

#get the emulator location
checkIfbinaryExists "emulator" "Please include the "\$ANDROID_HOME\\emulator" in your "\$PATH" environment!"

android=$(which emulator)