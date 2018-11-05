#!/bin/zsh
    #logo
    #indicators
    #gkeys
    #fkeys
    #modifiers
    #multimedia
    #arrows
    #numeric
    #functions
    #keys

g910-led -an 303030 
g910-led -gn keys 00ff00
g910-led -gn numeric 00ffff
g910-led -gn functions ff0000
g910-led -kn g9 0098f0
g910-led -gn fkeys 0098f0
g910-led -kn f9 303030
g910-led -gn modifiers ff0000
g910-led -gn arrows ffff00
g910-led -fx cycle logo ff
g910-led -c
