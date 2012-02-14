import sys
fp1= open(sys.argv[1],"r")
f = fp1.readlines();
var = "# Parse "+sys.argv[2]+" with score "
for i in xrange(len(f)):
    if var in f[i]:
        print f[i+1],
#        sys.exit()
fp1.close()

