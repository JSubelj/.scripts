#!/bin/python 
import os
import eyed3

genre_set = set()

for root, dirs, files in os.walk("/home/cleptes/Music"):
	for name in files:
		if name.endswith(".mp3"):
			try:
				genre_set.add(str(eyed3.load(root+os.sep+name).tag.genre))
			except:
				pass
		
print("No of genres: ",len(genre_set))
with open("~/.scripts/genres.txt", "w") as f:
	for item in genre_set:
		f.write("%s\n" % item)

