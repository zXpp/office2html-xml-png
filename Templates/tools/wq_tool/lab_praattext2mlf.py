#!/usr/bin/python
# find in path all '.TextGrid' text, include subdirtory!
import os,sys,math
path = '/home/winky'
textname = 'test_sub_dnn'#build mlf filename

file2 = path + '/%s.mlf.lab' % textname
f2 = open(file2, 'w')
f2.write('#!MLF!#\n')   # write the first line
for dirpath, dirnames, filenames in os.walk(path):
        for filename in filenames:
            if os.path.splitext(filename)[1] == '.TextGrid':
              	filepath = os.path.join(dirpath, filename)
		
		#main opt
		filename = filename[0 : filename.rfind('.')]
		string = filename
		file1 = path + '/%s.TextGrid' % string
		#file2 = path + '/%s.mlf' % string
		f1 = open(file1, 'r')
		#f2 = open(file2, 'wa')
		#f2.write('#!MLF!#\n')   # write the first line
		f2.write('"*/%s.lab"\n' % string) # write the second line
		iter = 0
		lastlabel =''
		while True:
		    line1 = f1.readline()
		    if not line1:
		        break
		    elif 'intervals [' in line1:
		        line2 = f1.readline()
		        line2_temp = line2.split()
		        sp = str(int(round(float(line2_temp[2]) * 10000000)))   # change start point
		        f2.write(sp) # write start point     
		        f2.write(' ')   # write a space
		        line3 = f1.readline()
		        line3_temp = line3.split()
		        ep = str(int(round(float(line3_temp[2]) * 10000000)))   # change end point
		        f2.write(ep) # write end point
		        f2.write(' ')   # write a space
		        line4 = f1.readline()
		        line4_temp = line4.split()
		        if 'cheer' in line4 and line4_temp[2] == '"cheer"':
		            iter = int(iter) + 1
		            f2.write('cheer\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'cheer'
		            else:
		                if lastlabel == 'cheer':
		                    print iter
		                    print 'ERROR1 !'
		            lastlabel = 'cheer'
		        elif 'applause' in line4 and line4_temp[2] == '"applause"':   
		            iter = int(iter) + 1
		            f2.write('applause\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'applause'
		            else:
		                if lastlabel == 'applause':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'applause' 
		        elif 'gunshot' in line4 and line4_temp[2] == '"gunshot"':   
		            iter = int(iter) + 1
		            f2.write('gunshot\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'gunshot'
		            else:
		                if lastlabel == 'gunshot':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'gunshot' 
		        elif 'fighting' in line4 and line4_temp[2] == '"fighting"':   
		            iter = int(iter) + 1
		            f2.write('fighting\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'fighting'
		            else:
		                if lastlabel == 'fighting':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'fighting' 
		        elif 'laughter' in line4 and line4_temp[2] == '"laughter"':   
		            iter = int(iter) + 1
		            f2.write('laughter\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'laughter'
		            else:
		                if lastlabel == 'laughter':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'laughter' 
		        elif 'music' in line4 and line4_temp[2] == '"music"':   
		            iter = int(iter) + 1
		            f2.write('music\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'music'
		            else:
		                if lastlabel == 'music':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'music' 
		        elif 'noise' in line4 and line4_temp[2] == '"noise"':   
		            iter = int(iter) + 1
		            f2.write('noise\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'noise'
		            else:
		                if lastlabel == 'noise':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'noise' 
                        elif 'other' in line4 and line4_temp[2] == '"other"':   
		            iter = int(iter) + 1
		            f2.write('other\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'other'
		            else:
		                if lastlabel == 'other':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'other' 
                        elif 'speech' in line4 and line4_temp[2] == '"speech"':   
		            iter = int(iter) + 1
		            f2.write('speech\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'speech'
		            else:
		                if lastlabel == 'speech':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'speech' 
                        elif 'rain' in line4 and line4_temp[2] == '"rain"':   
		            iter = int(iter) + 1
		            f2.write('rain\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'rain'
		            else:
		                if lastlabel == 'rain':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'rain' 
                        elif 'river' in line4 and line4_temp[2] == '"river"':   
		            iter = int(iter) + 1
		            f2.write('river\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'river'
		            else:
		                if lastlabel == 'river':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'river' 
                        elif 'wind' in line4 and line4_temp[2] == '"wind"':   
		            iter = int(iter) + 1
		            f2.write('wind\n') # write label
		            if int(iter) == 1:
		                lastlabel = 'wind'
		            else:
		                if lastlabel == 'wind':
		                    print iter
		                    print 'ERROR2 !'
		            lastlabel = 'wind' 
		        else:
			     f2.write('SN\n') # leak label
		             print iter
		             print 'ERROR3 !'
		#             sys.exit()
		f2.write('.\n')   # write the last line
		f1.close
		f2.close

               	print("file:" + filepath)
               	input_file = open(filepath)
               	text = input_file.read()
               	input_file.close()
               
              	output_file = open( filepath, 'w')
               	output_file.write(text)
               	output_file.close()
#string = 'car3'
#path = '/home/jinhai/jh'
#file1 = path + '/%s.TextGrid' % string
#file2 = path + '/%s.mlf' % string
#f1 = open(file1, 'r')
#f2 = open(file2, 'wa')
#f2.write('#!MLF!#\n')   # write the first line
#f2.write('"*/%s.lab"\n' % string) # write the second line
#iter = 0
#lastlabel =''
#while True:
#    line1 = f1.readline()
#    if not line1:
#        break
#    elif 'intervals [' in line1:
#        line2 = f1.readline()
#        line2_temp = line2.split()
#        sp = str(int(round(float(line2_temp[2]) * 10000000)))   # change start point
#        f2.write(sp) # write start point     
#        f2.write(' ')   # write a space
#        line3 = f1.readline()
#        line3_temp = line3.split()
#        ep = str(int(round(float(line3_temp[2]) * 10000000)))   # change end point
#        f2.write(ep) # write end point
#        f2.write(' ')   # write a space
#        line4 = f1.readline()
#        line4_temp = line4.split()
#        if 'cheer' in line4 and line4_temp[2] == '"cheer"':
#            iter = int(iter) + 1
#            f2.write('cheer\n') # write label
#            if int(iter) == 1:
#                lastlabel = 'cheer'
#            else:
#                if lastlabel == 'cheer':
#                    print iter
#                    print 'ERROR1 !'
#            lastlabel = 'cheer'
#        elif 'applause' in line4 and line4_temp[2] == '"applause"':   
#            iter = int(iter) + 1
#            f2.write('applause\n') # write label
#            if int(iter) == 1:
#                lastlabel = 'applause'
#            else:
#                if lastlabel == 'applause':
#                    print iter
#                    print 'ERROR2 !'
#            lastlabel = 'applause' 
#        elif 'gunshot' in line4 and line4_temp[2] == '"gunshot"':   
#            iter = int(iter) + 1
#            f2.write('gunshot\n') # write label
#            if int(iter) == 1:
#                lastlabel = 'gunshot'
#            else:
#                if lastlabel == 'gunshot':
#                    print iter
#                    print 'ERROR2 !'
#            lastlabel = 'gunshot' 
#        elif 'SN' in line4 and line4_temp[2] == '"SN"':   
#            iter = int(iter) + 1
#            f2.write('SN\n') # write label
#            if int(iter) == 1:
#                lastlabel = 'SN'
#            else:
#                if lastlabel == 'SN':
#                    print iter
#                    print 'ERROR2 !'
#            lastlabel = 'SN' 
#        elif 'laughter' in line4 and line4_temp[2] == '"laughter"':   
#            iter = int(iter) + 1
#            f2.write('laughter\n') # write label
#            if int(iter) == 1:
#                lastlabel = 'laughter'
#            else:
#                if lastlabel == 'laughter':
#                    print iter
#                    print 'ERROR2 !'
#            lastlabel = 'laughter' 
#        elif 'BELL' in line4 and line4_temp[2] == '"BELL"':   
#            iter = int(iter) + 1
#            f2.write('BELL\n') # write label
#            if int(iter) == 1:
#                lastlabel = 'BELL'
#            else:
#                if lastlabel == 'BELL':
#                    print iter
#                    print 'ERROR2 !'
#            lastlabel = 'BELL' 
#        elif 'IN' in line4 and line4_temp[2] == '"IN"':   
#            iter = int(iter) + 1
#            f2.write('IN\n') # write label
#            if int(iter) == 1:
#                lastlabel = 'IN'
#            else:
#                if lastlabel == 'IN':
#                    print iter
#                    print 'ERROR2 !'
#            lastlabel = 'IN' 
#        else:
#             print iter
#             print 'ERROR3 !'
##             sys.exit()
#f2.write('.\n')   # write the last line
#f1.close
#f2.close
