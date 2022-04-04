#!/usr/bin/python

from ytmusicapi import YTMusic
import sys
import pprint
import os

pp = pprint.PrettyPrinter(indent=4)


ytmusic = YTMusic("/home/jeffery/.config/mopidy/auth.json")

if (len(sys.argv) < 2):
  print (sys.argv[0]+" search <something> | artist <band> | album <videoId>")
else:
  print("At your service")
  if (sys.argv[1]=="search"):
    print("Searching "+sys.argv[2])
    something=ytmusic.search(sys.argv[2],"artists")
    pp.pprint(something)
    for x in something:
      print (x["category"]+" "+x["artist"]+" - "+x["browseId"])
  elif(sys.argv[1]=="artist"):
    print("Searching "+sys.argv[2])
    something=ytmusic.search(sys.argv[2],"artists")
    #print(something)
    for x in something:
      try:
        somethingmore=ytmusic.get_artist(x["browseId"])
        print(x["artist"])
        #print(somethingmore)
        someAlbums=ytmusic.get_artist_albums(x["browseId"], somethingmore["albums"]["params"])
        for y in someAlbums:
          print ("--------------------------------------------------------------------------------------")
          print(y["title"]+" "+y["browseId"])
        someAlbums=ytmusic.get_artist_albums(x["browseId"], somethingmore["singles"]["params"])
        for y in someAlbums:
          print ("--------------------------------------------------------------------------------------")
          print(y["title"]+" "+y["browseId"])
      except:
        pass
  elif(sys.argv[1]=="album"):
    print("Grabby")
    album=ytmusic.get_album(sys.argv[2])
    print(album["title"])
    for x in album["tracks"]:
      print ("--------------------------------------------------------------------------------------")
      print(x["title"]+ " "+ x["videoId"])
      song=ytmusic.get_song(x["videoId"])
      songURL=song["microformat"]["microformatDataRenderer"]["iosAppArguments"]
      print(songURL)
      os.system("get_song "+songURL)
      os.system("tsp sleep 100")


