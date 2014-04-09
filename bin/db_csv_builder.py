import sys, os

def break_csv(fname):
   f=open(fname)
   os.chdir("/CCASE/vobs/TCS_MGH/config")
   STOPAT=90
   counter=0
   sCSV=smallCSV()
   sCSV.prepareFile()
   for line in f:
      counter+=1
      sCSV.outLine(line)
      if (counter >= STOPAT):
         counter=0
         sCSV.processFile()
         sCSV.prepareFile()

   sCSV.processFile()




class smallCSV:
   here=1
   water=0
   good=0
   def outLine(self, line):
      self.water.write(line)
      self.good=1

   def prepareFile(self):
      print "Open temp file for write"
      self.water = open("smallcsvjwi12345.csv", 'w') 
      self.good=0


   def processFile(self):
      print "\n\n================\nProcess file.\n================\n\n"
      if (self.good == 0):
         print ("Empty CSV" + "smallcsvjwi12345.csv")
         return

      #if (self.here > 1):
      #   sys.exit()
      self.water.close()
      os.system("python $TCS_ROOT/config/update.py apply" + str(self.here) + ".sql smallcsvjwi12345.csv CLINICAL")
      self.here +=1


break_csv (sys.argv[1])
