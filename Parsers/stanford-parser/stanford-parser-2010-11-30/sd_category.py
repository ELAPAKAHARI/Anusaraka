import sys
fp = open(sys.argv[2], 'w')

for line in open(sys.argv[1]).readlines():
    count = 0
    if len(line) > 1 and "SENTENCE_SKIPPED_OR_UNPARSABLE" not in line and "/" in line:	
	mylist = line.split()
	for word_cat in mylist:
	    count += 1
	    word_tag = word_cat.split("/")
	    if  word_tag[0].istitle() and count > 1 and word_tag[1] == 'NN':
		fp.write("(id-sd_cat\tP%s\tNNP)\n" % count) #Ex. We ate at Joe's Diner last week. The Master said, if I did not go, how would you ever see? 
	    else:
		fp.write("(id-sd_cat\tP%s\t%s)\n" % (count, word_tag[1]))
        fp.write(";~~~~~~~~~~\n")
fp.close()
