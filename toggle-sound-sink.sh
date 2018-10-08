#!/bin/bash 
function string_parse {
	sink="$(python << END
import sys

sinks="""$sinks"""
sinks=sinks.split("\tname:")[1:]
sinks=[y.replace(" ","").replace("<","").replace(">","").replace("\n","") for y in sinks]

default_sink="""$def_sink"""
default_sink=default_sink.split("Default Sink: ")[1]

index_of_def_sink = sinks.index(default_sink)

if index_of_def_sink+1 == len(sinks):
        print(0)
else:
        print(index_of_def_sink+1)
END
)"
echo $sink
}



sinks=`pacmd list-sinks | grep name:`
def_sink=`pactl info | grep 'Default Sink:'`
string_parse 




echo "Setting default sink to: $sink";
pacmd set-default-sink $sink
pacmd list-sink-inputs | grep index | while read line
do
echo "Moving input: ";
echo $line | cut -f2 -d' ';
echo "to sink: $sink";
pacmd move-sink-input `echo $line | cut -f2 -d' '` $sink

done
