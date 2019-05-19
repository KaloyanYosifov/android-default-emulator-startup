#! /bin/bash

function checkIfbinaryExists() {
    # execute the command and pass all output stdout and stderr to the void
    which $1 &> /dev/null
    
    # check the exist status
    # if it is not 0
    # then the command has failed

    if [ $? -ne 0 ]; then
        echo "$2"
        # exit with an error
        exit 1
    fi
}

function scriptUsage() {
    echo "You can use [-d or --detached to detach emulator from the terminal] [-system-libs use the libraries of the system instead of the android environement]"
    exit 0
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

# get the device name of the first device we find in the avd list
# we use awk to check if we are on the first line
# then we use the basename to remove the file path and extension to get the name of the device
deviceBaseName=$(basename $(avdmanager list avd | grep Path: | awk '{ if (NR == 1) { found_device=$2 } } END{ print(found_device) }') ".avd")
# empty line
echo

# if pgrep is empty when checking for adb
# start the daemon server
if [ -z $(pgrep adb) ]; then
    echo "Starting adb daemon server!"
    $(adb start-server)
fi

echo "Starting emulator"

options=""
detached=false

while [ $# -ne 0 ]; do
    case $1 in
        "-system-libs" )
            options="$options -use-system-libs"
            shift
            ;;
        "-d" | "--detached" )
            detached=true
            shift
            ;;
        "-h" | "--help" )
            scriptUsage
            shift
            ;;
        * )
            shift
            ;;
    esac
done

if [ $detached = true ]; then
    emulator @$deviceBaseName $options &> /dev/null &
    exit 0
fi

emulator @$deviceBaseName $options