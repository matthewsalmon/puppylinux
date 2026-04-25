#!/bin/bash  
MEETING_DATE=$(zenity --calendar \
  --title="Schedule Meeting" \
  --text="Pick a date for the meeting:" \
  --day=15 \
  --month=9 \
  --year=2024)
 
if [ $? -eq 0 ]; then  
  zenity --info --text="Meeting scheduled for: $MEETING_DATE"  
fi  
