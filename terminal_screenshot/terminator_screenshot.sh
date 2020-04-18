## THIS SCRIPT RUN USING A SHORTCUT KEY IN KDE CUSTOM COMMANDS win + h
## THIS WILL TAKE screen shot
## https://github.com/sant527/django_basic_documentation_ver2/blob/master/README.md#how-to-take-screen-shot-of-terminator


set -x -o verbose;
export DISPLAY=:0.0 &&
#xdotool windowactivate "$(xdotool search  --desktop 0 --class Terminator)" &&

   # the below is to get the last seen window in a group of windows
   #windowid=$(xdotool search  --desktop 0 --class Terminator | awk 'NR==1{print $0}');
   # the below is to get the recent seen window in a group of windows
   xdotool search  --desktop 0 --class Terminator
   windowid=$(xdotool search  --desktop 0 --class Terminator | awk 'END{print}'); 
   width_ter=`xdotool getwindowgeometry $windowid | awk '/Geometry/' | awk '{match($0,/Geometry: ([0-9]+)x([0-9]+)/,a); print a[1]}'`
   height_ter=`xdotool getwindowgeometry $windowid | awk '/Geometry/' | awk '{match($0,/Geometry: ([0-9]+)x([0-9]+)/,a); print a[2]}'`
   echo $width_ter
   echo $height_ter

#xdotool windowsize ${windowid} $width_ter 620 &&
### xdotool search  --desktop 0 --class Terminator;
### windowid=$(xdotool search  --desktop 0 --class Terminator | awk 'END{print}'); 
### echo $windowid
### width_ter=`xdotool getwindowgeometry $windowid | awk '/Geometry/' | awk '{match($0,/Geometry: ([0-9]+)x([0-9]+)/,a); print a[1]}'`
### echo $width_ter
### height_ter=`xdotool getwindowgeometry $windowid | awk '/Geometry/' | awk '{match($0,/Geometry: ([0-9]+)x([0-9]+)/,a); print a[2]}'`
### echo $height_ter
### xdotool windowsize ${windowid} $width_ter 916

#xdotool windowsize  --usehints ${windowid} 20 60 &&

#xdotool windowmove ${windowid} +402 +52 &&

xdotool windowactivate ${windowid} &&

FILE=""

crop_a=$((21))
crop_b=$((0))
#crop_a=$((21+36))
#crop_b=$((1))

DIR="/home/simha/terminator_screenshots"
# init
# look for empty dir 
if [ "$(ls -A $DIR)" ]; then
   echo "Take action $DIR is not Empty"
else
   echo "$DIR is Empty"
   #sleep 1
   filename="$(date +%Y-%m-%d-%H_%M_%S).png"
   echo $filename
   import -window ${windowid} -crop +0+${crop_a} -crop +0-${crop_b} /home/simha/terminator_screenshots/${filename}
   #convert /home/simha/terminator_screenshots/${filename} -gravity South -chop 0x5 /home/simha/terminator_screenshots/${filename}
   #import -window "$(xdotool search  --desktop 0 --class Terminator)" /home/simha/terminator_screenshots/${filename}
   #sleep 1
   #gwenview /home/simha/terminator_screenshots/${filename}
   #sleep 1
fi


sleep 1

### echo "MotionNotify 508 251" > /home/simha/.public_html/xmacros_terminator_screenshot
### echo "KeyStrPress Control_L" >> /home/simha/.public_html/xmacros_terminator_screenshot
### echo "Delay 22" >> /home/simha/.public_html/xmacros_terminator_screenshot
### echo "KeyStrPress Shift_L" >> /home/simha/.public_html/xmacros_terminator_screenshot
### echo "Delay 10" >> /home/simha/.public_html/xmacros_terminator_screenshot
### for i in {1..33}
### do
### 	echo "KeyStrPress Up" >> /home/simha/.public_html/xmacros_terminator_screenshot
### 	echo "KeyStrRelease Up" >> /home/simha/.public_html/xmacros_terminator_screenshot
### 	echo "Delay 10" >> /home/simha/.public_html/xmacros_terminator_screenshot
### done
### 
### echo "KeyStrRelease Control_L" >> /home/simha/.public_html/xmacros_terminator_screenshot
### echo "KeyStrRelease Shift_L" >> /home/simha/.public_html/xmacros_terminator_screenshot

echo "MotionNotify 508 251" > /home/simha/.public_html/xmacros_terminator_screenshot
echo "KeyStrPress Shift_L" >> /home/simha/.public_html/xmacros_terminator_screenshot
echo "Delay 400" >> /home/simha/.public_html/xmacros_terminator_screenshot
echo "KeyStrPress Prior" >> /home/simha/.public_html/xmacros_terminator_screenshot
echo "KeyStrRelease Prior" >> /home/simha/.public_html/xmacros_terminator_screenshot
echo "Delay 408" >> /home/simha/.public_html/xmacros_terminator_screenshot
echo "KeyStrRelease Shift_L" >> /home/simha/.public_html/xmacros_terminator_screenshot


### echo "Delay 1000" > /home/simha/.public_html/xmacros_terminator_screenshot
### echo "MotionNotify 724 379" >> /home/simha/.public_html/xmacros_terminator_screenshot
### echo "ButtonPress 4" >> /home/simha/.public_html/xmacros_terminator_screenshot
### echo "Delay 8000" >> /home/simha/.public_html/xmacros_terminator_screenshot
### echo "ButtonRelease 4" >> /home/simha/.public_html/xmacros_terminator_screenshot

xmacroplay < "/home/simha/.public_html/xmacros_terminator_screenshot"

#sleep 1
filename="$(date +%Y-%m-%d-%H_%M_%S).png"
echo $filename
import -window ${windowid} -crop +0+${crop_a} -crop +0-${crop_b}  /home/simha/terminator_screenshots/${filename}
#convert /home/simha/terminator_screenshots/${filename} -gravity South -chop 0x5 /home/simha/terminator_screenshots/${filename}

#import -window "$(xdotool search  --desktop 0 --class Terminator)" /home/simha/terminator_screenshots/${filename}
#sleep 1
gwenview /home/simha/terminator_screenshots/${filename}

#convert -append $(ls -1 *.png | sort -r) out.jpg