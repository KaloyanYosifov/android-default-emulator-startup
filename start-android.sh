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
checkIfbinaryExists "avdmanager" "Please install Android Studio!"

#get the emulator location
checkIfbinaryExists "emulator" "Please include the '\$ANDROID_HOME\\emulator' in your '\$PATH' environment!"

#get the abd location
checkIfbinaryExists "adb" "Please include the '\$ANDROID_HOME\\platform-tools' in your '\$PATH' environment!"

# get the basename of the device we are going to use
# this is still work in progress
# TODO check if we have multiple devices how is this command going to handle it AND find a better way to get the devices name
echo "Getting Device Name"
deviceBaseName=$(basename $(avdmanager list avd | grep Path: | sed "s/Path\:/ /g") ".avd")

# empty line
echo

# check if there is a process where adb is running it
# if the if statement is empty it means no pid is found with that command name
# if not we start the server

if [ -z $(ps -C adb --no-headers -o pid) ]; then
    echo "Starting adb daemon server!"
    $(adb start-server)
fi