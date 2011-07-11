# This program takes sd_stanford.sh programs output as input. Where basic, propagated and tree SDs are produces by the program sd_stanford.sh. 

import sys
basic_SD = open(sys.argv[2], 'w')
propagated_SD = open(sys.argv[3], 'w')
tree_SD = open(sys.argv[4], 'w')
tree_rel_lst=[]
propagated_rel_lst=[]
count = 0
for line in open(sys.argv[1]).readlines():
    if len(line) > 1 and "SENTENCE_SKIPPED_OR_UNPARSABLE" not in line and "/" in line:
        count = 0
    if line == '\n':
        count += 1

    if count == 1 and (line.startswith("pcomp(") or line.startswith("prep(") or line.startswith("pobj(") or line.startswith("mwe(") ) and line != '\n': # this condition extracts only prepositional relations form basic SDs.
        basic_SD.write(line)  
    if count == 2 and line == '\n':
	basic_SD.write(";~~~~~~~~~~\n")

    if count == 2 and line != '\n': # This condition extracts propagation SDs.
	propagated_SD.write(line)
#    if count == 2 and line == '\n':
#	basic_SD.write(";~~~~~~~~~~\n")
    if count == 3 and line == '\n':
        propagated_SD.write(";~~~~~~~~~~\n")

    if count  == 3 and line != '\n': # This condition extracts tree SDs.
        tree_SD.write(line)
    if count == 4 and line == '\n':
        tree_SD.write(";~~~~~~~~~~\n")


basic_SD.close()
propagated_SD.close()
tree_SD.close()
