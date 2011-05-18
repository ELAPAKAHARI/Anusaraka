import sys; import os; import commands
RES_SWRK_TAB = []; count =0;prk=0
INPUT = []; inp_cnt =0
tran_cnt = 0; OP_TAR_ARR_TRAN1 = []; OP_TAR_ARR_TRAN2 = []; OP_TAR_ARR_TRAN3 = []; OTAR_TRAN3 = []
i=4; semwrk_prep=[]
SCON_FOR_tran3 = []; st3c =0
SCON_FOR_tran4 = []; st4c =0
rst = open('/home/sukhada/tmp_anu_dir/tmp/m_tmp/2.1/ol-EG-TR.diag',"r")
inp='';sent='';sent_len=0;sentence=''
TARG_CODE = 0; a = ''; s = '';b = ''
for f in rst.readlines():
        inp = sent
        sent = f
        if '*Original Input' in f:
                sent_len = 1
	if f == '\n':
                sent_len == 0
	if sent_len==1 and '*Original Input' in inp:
		sentence=f
        if f == "\n":
           count = 0
           inp_cnt = 0
        if "*RESOLVED SWORK RECORDS*" in f:
           count = 1
        if count == 1:
           a = f.split()
           RES_SWRK_TAB.append(a)
        if rst.readlines() == "\n" and count == 1:
           count = 0
           RES_SWRK_TAB.append(a)
        if f == "*EOS*\n":
           tran_cnt = 0
        if "* OUTPUT TARGET ARRAYS IN tran3  *"  in f :
                tran_cnt = 3
        if tran_cnt == 3:
            OP_TAR_ARR_TRAN3.append(f.split())
            OTAR_TRAN3.append(f.split())
rst.close()
if len(OTAR_TRAN3) <18 and len(sentence.split()) >1:
        print 'PARSER FAILED'
        print sentence,

wrong=[]
for i in xrange(5,len(RES_SWRK_TAB)):
	wrong.append(RES_SWRK_TAB[i][13])
if '1' not in wrong:
	print 'PARSER FAILED'
	print sentence,

f = open('j',"r")
her=[]
for i in f.readlines():
    if ' then ' in i:
	s=i.split(' then ')
	s[0].strip()
	if s[0].endswith(','):
	    pass
	else:
 	    sent=s[0]+', then '+ s[1].strip()
	    print sent
    if ' her ' in i or 'Her ' in i or 'play' in i or ' like ' in i:
	sent_wrds = i.split()
	f1 = open('jnk1',"w")
	a = i.strip()
	f1.write(a)
	f1.close()
	s = commands.getoutput("sh myrun.sh jnk1")
	ss = s.split('\n')
	transformed_s=''
	for j in range(len(ss)):
#	    Transforming "her"
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
	        print transformed_s.strip()
#	    Transforming "play"
	    if 'play' in ss[j] and '_VB' in ss[j] and 'playing' not in ss[j] :
                strng = ss[j].split()
                for k in range(len(strng)):
                    if 'play' in strng[k] and 'VB' in strng[k] and '_VBZ' not in strng[k-1]:
                        transformed_s=transformed_s+' '+'is playing'
                    else:
			a = strng[k].split('_')
                        transformed_s=transformed_s+' '+a[0]
                print transformed_s
#	    Transforming "like"
            if ' like_VBP ' in ss[j]:
                strng = ss[j].split()
                for k in range(len(strng)):
		    st = strng[k].split('_')
#		    print st, 'aaaaaaaaaaaaaaaaaaaa'
                    if 'like' == st[0] and 'VBP' == st[1] :
                        transformed_s=transformed_s+' love'
                    else:
                        transformed_s=transformed_s+' '+st[0]
                print transformed_s



