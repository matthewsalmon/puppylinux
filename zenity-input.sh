#!/bin/bash  
NAME=$(zenity --entry \
  --title="User Input" \
  --text="Enter your name:" \
  --entry-text="John Doe")  # Default value  
 
# Check if user clicked "OK" (Zenity returns exit code 0 on success)  
if [ $? -eq 0 ]; then  
  zenity --info --text="Hello, $NAME!"  
else  
  zenity --error --text="You cancelled the input."  
fi  
