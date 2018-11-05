#!/bin/bash
echo test > ~/test
rsync -avu --delete /home/cleptes/Programming/ /home/cleptes/HDD_Documents/programming/
