#!/bin/bash 

sinks=`pacmd list-sinks | grep name: | grep -o "alsa_output[^>]*"`
current=`pactl info | grep 'Default Sink:' | grep -o "alsa_output.*"`
for s in $sinks;
do
	if [[ "$s" != "$current" ]]; then next="$s"; break; fi
done



echo "Setting default sink to: $next";
pacmd set-default-sink $next
pacmd list-sink-inputs | grep index | while read line
do
echo "Moving input: ";
echo $line | cut -f2 -d' ';
echo "to sink: $next";
pacmd move-sink-input `echo $line | cut -f2 -d' '` $next

done
