import sys
import os
import commands

#f = open(sys.argv[1],"r")
f = open('jnk',"r")
her=[]
for i in f.readlines():
    if ' her ' in i or 'Her ' in i:
	sent_wrds = i.split()
	f1 = open('jnk1',"w")
	a = i.strip()
	f1.write(a)
	f1.close()
	s = commands.getoutput("sh myrun.sh jnk1")
	ss = s.split('\n')
	transformed_s=''
	for j in range(len(ss)):
	    if ' her_PRP' in ss[j] or 'Her_PRP' in ss[j] :
		strng = ss[j].split()
 	        for k in range(len(strng)):
		    a = strng[k].split('_')
		    if a[0].lower() == 'her' and a[1] == 'PRP$':
 		        transformed_s=transformed_s+' '+'his '
		    elif a[0].lower() == 'her' and a[1] == 'PRP':
                        transformed_s=transformed_s+' '+'him '
		    else:
			transformed_s=transformed_s+' '+a[0]
	        print transformed_s


