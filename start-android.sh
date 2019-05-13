#! /bin/bash

checkIfbinaryExists()
{
    # $1 is the binary we are looking for
    # $2 is the message we are going to echo to the command user

    # get the binary location
    # and send the errors (2>) to null
    if [ -z $(which $1 2> /dev/null) ]; then
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

# if pgrep is empty when checking for adb
# start the daemon server
if [ -z $(pgrep adb) ]; then
    echo "Starting adb daemon server!"
    $(adb start-server)
fi

echo "Starting emulator"

options=""

if [ "$1" == "-system-libs" ] || [ "$2" == '-system-libs' ]; then
    options="$options -use-system-libs"
fi

if [ "$1" == "-d" ] || [ "$2" == '-d' ]; then
    emulator @$deviceBaseName $options > /dev/null 2>&1 &
    exit 0
fi

emulator @$deviceBaseName $options