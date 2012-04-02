Steps to add dictionaries in GoldenDict
======================================
1.From Synaptic package Manager install the following packages
	goldendict
	dictfmt

2.In terminal enter goldendict
  ---> GoldenDict opens  (By default we can find Wordnet and English Wikipedia added)
  ---> To add any dictionary 
           |
           V
           ===>  Go to Edit --> Dictionaries -->Add --> Rescan now 
                 (Note:  Only path of the dictionary need to be added .)

3.Dictionaries need to be in Dictd File format
  For this we can refer:: http://en.wikipedia.org/wiki/DICT#DICT_file_format
  Dictionary should be in Key and Value pair.
  Each Key and Value need to be separated by ":".
  There should be ":" before Key (ie. at the beginning of the line.)
  EX::   To add the word 'sculpture' with hindi meaning 'mUrwikalA', format should be as shown below
 	 :sculpture:mUrwikalA

4.Once the file is in Dictd file format following command need to be run :
	dictfmt --utf8 --allchars -s "My Dictionary" -j mydict < mydict.txt

         -->Where mydict.txt is the dictionary file that need to be added
         -->mydict is the name that is need to be displayed in GoldenDict.
         -->mydict.dict, mydict.index  files are created once the above command runs successfully.

5.Now the file is ready to Add in the GoldenDict.

6.shabdanjali and iit-bombay are added in the GoldenDict.

7.shabdanjali is added from the data given by Chaitanya Sir. 'shabdanjali.dict.dz' is the file extracted from Star-Dict and    this can be added directly into GoldenDict. As GoldenDict allows the Star Dict format without editing anything.
      (Note: shabdanjali.dict.dz file needs shabdanjali.idx and shabdanjali.ifo file)

8.iit-bombay dictionary is copied from the 'UW-Hindi_Dict-20090403.txt'.
         -->Above file is modified in such a way that the pattern is as shown
                :English-word:Hindi-meaning  
                 Extra information
              EX:-  :auntie:मौसी
		    (icl>mother's sister)
		    (Noun,   Female   ,Animate   ,For nouns ending with  I  ) <H,0,0>;
          -->UW-Hindi_Dict-20090403.txt file originally contains the above information like this
                [मौसी] {} "auntie(icl>mother's sister)" (N,FEMALE,ANIMT,NI) <H,0,0>;
                The Ontologies like ANIMT, N, NI etc full forms are extracted from 
		  --->  2011_01_31_Ontology_Developed_by_IIT-B_384.doc
                  --->  http://tdil.mit.gov.in/pdf/Vishwabharat/tdiljan2002.pdf (pg.83-86)
   		These Ontologies are mapped in Ontology.lex file.
                        Ex:  ANIMT is mapped as Animated .
           -->Mapped file is passed as i/p for step-4. '
                  (NOTE:: I/p: file is 'iit-bombay.txt'. Any changes done in this should be compiled with flex file
                          and this output is passed to Step-4)


***Any modifications to be done in iit-bombay dictionary should be done in iit-bombay.txt1 which is in src/ and Step 4 need to be followed.

Changes done in 'iit-bombay.txt'
-------------------------------
1.lnk is replaced as link
