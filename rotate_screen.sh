#!/bin/bash
# This script rotates the screen and touchscreen input 90 degrees each time it is called, 
# also disables the touchpad, and enables the virtual keyboard accordingly

# by Ruben Barkow: https://gist.github.com/rubo77/daa262e0229f6e398766

#### configuration
# find your Touchscreen and Touchpad device with `xinput`
TouchscreenDevice='ELAN Touchscreen'
TouchpadDevice='ELAN0501:00 04F3:3037 Touchpad'
KeyboardDevice='AT Translated Set 2 keyboard'

if [ "$1" = "--help"  ] || [ "$1" = "-h"  ] || [ -z "$1" ]; then
    echo 'Usage: rotate-screen.sh [OPTION]'
    echo
    echo 'This script rotates the screen and touchscreen input 90 degrees each time it is called,'
    echo 'also disables the touchpad, and enables the virtual keyboard accordingly'
    echo
    echo Usage:
    echo ' -h --help display this help'
    echo ' -l rotates the screen +90°'
    echo ' -r rotates the screen -90°'
    echo ' -u rotates the screen 180°'
    echo ' -n rotates the screen back to normal'
    exit 0
fi

touchpadEnabled=$(xinput --list-props "$TouchpadDevice" | awk '/Device Enabled/{print $NF}')
screenMatrix=$(xinput --list-props "$TouchscreenDevice" | awk '/Coordinate Transformation Matrix/{print $5$6$7$8$9$10$11$12$NF}')

# Matrix for rotation
# ⎡ 1 0 0 ⎤
# ⎜ 0 1 0 ⎥
# ⎣ 0 0 1 ⎦
normal='1 0 0 0 1 0 0 0 1'
normal_float='1.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,1.000000'

#⎡ -1  0 1 ⎤
#⎜  0 -1 1 ⎥
#⎣  0  0 1 ⎦
inverted='-1 0 1 0 -1 1 0 0 1'
inverted_float='-1.000000,0.000000,1.000000,0.000000,-1.000000,1.000000,0.000000,0.000000,1.000000'

# 90° to the left 
# ⎡ 0 -1 1 ⎤
# ⎜ 1  0 0 ⎥
# ⎣ 0  0 1 ⎦
left='0 -1 1 1 0 0 0 0 1'
left_float='0.000000,-1.000000,1.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000'

# 90° to the right
#⎡  0 1 0 ⎤
#⎜ -1 0 1 ⎥
#⎣  0 0 1 ⎦
right='0 1 0 -1 0 1 0 0 1'

# No need because Acer Spin 3 disables keyboard and touchpand in hardware no need for software
# if [ "$1" != "-n" ]
# then
#     echo "Disabling touchpad and keyboard"
#     xinput disable "$TouchpadDevice"
#     xinput disable "$KeyboardDevice"
# else
#     echo "Enabling touchpad and keyboard"
#     xinput enable "$KeyboardDevice"
#     xinput enable "$TouchpadDevice"
#     xinput --set-prop "ELAN0501:00 04F3:3037 Touchpad" "libinput Accel Speed" 0.3
# fi

if [ "$1" == "-u" ]
then
  echo "Upside down"
  xrandr -o inverted
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $inverted
elif [ "$1" == "-l" ]
then
  echo "90° to the left"
  xrandr -o left
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $left
elif [ "$1" == "-r" ]
then
  echo "90° to the right"
  xrandr -o right
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $right
elif [ "$1" == "-n" ]
then
  echo "Back to normal"
  xrandr -o normal
  xinput set-prop "$TouchscreenDevice" 'Coordinate Transformation Matrix' $normal
fi
