#/bin/sh
 source ~/.bash_profile

 export LC_ALL=
 export LC_ALL=en_US.UTF-8

 if ! [ -d $HOME_anu_tmp ] ; then
     echo $HOME_anu_tmp " directory does not exist "
     echo "Creating "$HOME_anu_tmp 
    mkdir $HOME_anu_tmp
 fi

# MYPATH1=`pwd`
 MYPATH1=$HOME_anu_tmp/tmp/$1_tmp

 MYPATH=$HOME_anu_tmp
 cp $1 $MYPATH/. 

 if ! [ -d $MYPATH/tmp ] ; then
    echo "tmp  does not exist "
    echo " Creating tmp "
    mkdir $MYPATH/tmp
 fi

 if ! [ -d $MYPATH1/help ] ; then
    echo "help dir  does not exist "
    echo "Creating help dir"
    mkdir $MYPATH1/help
 fi

 if  [ -e $MYPATH/tmp/$1_tmp ] ; then
    rm -rf $MYPATH/tmp/$1_tmp
 fi

 mkdir $MYPATH/tmp/$1_tmp

 echo "Saving Format info ..."

 $HOME_anu_test/Anu/stdenglish.sh $1 $MYPATH
 $HOME_anu_test/Anu/pre_process.sh $1 $MYPATH
 $HOME_anu_test/Anu/save_format.sh $1 $MYPATH

 echo "Saving word information"
 cd $HOME_anu_test/Anu_src
 ./word.out < $MYPATH/tmp/tmp_save_format/$1.fmt_split $MYPATH/tmp $1
 ./rm_tags.out < $MYPATH/tmp/$1_tmp/new_text.txt > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt

  echo "Saving morph information"
  cd $HOME_anu_test/apertium/
  sed 's/\([^0-9]\)\.\([^0-9]*\)/\1 \.\2/g'  $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt | sed 's/?/ ?/g'| sed 's/\"/\" /g'  | sed 's/!/ !/g' > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tmp
  apertium-destxt $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tmp  | lt-proc -a en.morf.bin | apertium-retxt > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.morph
  perl morph.pl $MYPATH $1 < $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.morph

  echo "Calling POS Tagger and Chunker (APERTIUM)" 
  cd $HOME_anu_test/apertium
  sh run_chunker_and_tagger.sh $1

  cd $HOME_anu_test/Anu_src
  ./aper_chunker.out $MYPATH/tmp/$1_tmp/chunk.txt < $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.chunker

  echo "Calling Stanford parser"
  cd $HOME_anu_test/Parsers/stanford-parser/stanford-parser-2010-11-30/
  sh run_penn.sh $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp 2>/dev/null
  sed -n -e "H;\${g;s/Sentence skipped: no PCFG fallback.\nSENTENCE_SKIPPED_OR_UNPARSABLE/(ROOT (S ))\n/g;p}"  $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp | sed -n -e "H;\${g;s/\n//g;p}" | sed 's/)(ROOT/)\n(ROOT/g' > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn
  sh run_stanford-parser.sh $1 $MYPATH > /dev/null

  #running stanford NER (Named Entity Recogniser) on whole text.
  echo "Finding NER... "
  cd $HOME_anu_test/Parsers/stanford-parser/stanford-ner-2008-05-07/
  sh run-ner.sh $1

  cd $MYPATH/tmp/$1_tmp
  sed 's/&/\&amp;/g' one_sentence_per_line.txt|sed -e s/\'/\\\'/g |sed 's/\"/\&quot;/g' |sed  "s/^/(Eng_sen \"/" |sed -n '1h;2,$H;${g;s/\n/\")\n;~~~~~~~~~~\n/g;p}'|sed -n '1h;2,$H;${g;s/$/\")\n;~~~~~~~~~~\n/g;p}' > one_sentence_per_line_tmp.txt
  $HOME_anu_test/Anu_src/split_file.out one_sentence_per_line_tmp.txt dir_names.txt English_sentence.dat
  $HOME_anu_test/Anu_src/split_file.out chunk.txt dir_names.txt chunk.dat
  $HOME_anu_test/Anu_src/split_file.out sd-lexicalize_info.txt dir_names.txt sd-lexicalize_info.dat
  $HOME_anu_test/Anu_src/split_file.out sd-tree_relation.txt dir_names.txt sd-tree_relations_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out sd-basic_relation.txt dir_names.txt sd-basic_relations_tmp1.dat
  $HOME_anu_test/Anu_src/split_file.out sd-propagation_relations.txt dir_names.txt sd-propagation_relations_tmp1.dat
  $HOME_anu_test/Anu_src/split_file.out sd_word.txt dir_names.txt sd_word_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out sd_numeric_word.txt dir_names.txt sd_numeric_word_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out sd_category.txt dir_names.txt sd_category.dat
  $HOME_anu_test/Anu_src/split_file.out one_sentence_per_line.txt.ner dir_names.txt ner.dat

  $HOME_anu_test/Anu_src/split_file.out sd-original-relations.txt  dir_names.txt  sd-original-relations.dat

  echo 'matching compounds......'
  grep -v '^$' $MYPATH/tmp/$1.snt  > $MYPATH/tmp/$1_tmp/$1.snt
##NOTE: While 'matching compounds', using one_sentence_per_line.txt_tmp problem occured when we get punctuations in between the sentence. Ex: I am warning you for the last time, stop talking! 
## So '$1.snt' file which contains only sentences without punctuations is used. (Modified by Roja (11-08-11)) 
  perl $HOME_anu_test/Anu_src/Compound-dict.pl $HOME_anu_test/Anu_databases/compound.gdbm  $1.snt > compound_phrase.txt
  perl $HOME_anu_test/Anu_src/Match-sen.pl $HOME_anu_test/Anu_databases/Complete_sentence.gdbm  ../$1.snt one_sentence_per_line.txt > sen_phrase.txt

  $HOME_anu_test/Anu_src/split_file.out sen_phrase.txt dir_names.txt sen_phrase.dat
  $HOME_anu_test/Anu_src/split_file.out compound_phrase.txt dir_names.txt compound_phrase.dat
 
 cd $HOME_anu_test/bin
 while read line
 do
    echo "Hindi meaning using Stanford parser" $line
    timeout 500 ./run_sentence_stanford.sh $1 $line 1 $MYPATH
    echo ""
 done < $MYPATH/tmp/$1_tmp/dir_names.txt
 
 cd $MYPATH/tmp/$1_tmp/
 echo "(defglobal ?*path* = $HOME_anu_test)" > path_for_html.clp
 echo "(defglobal ?*mypath* = $MYPATH)" >> path_for_html.clp
 echo "(defglobal ?*filename* = $1)" >> path_for_html.clp

 echo "Calling Interface related programs"
 sh $HOME_anu_test/shell_scripts/ClipsToAnu_browser_intfc.sh $1 $MYPATH
 echo "<html><body>" > $MYPATH/tmp/$1_tmp/$1.txt.html
 cat $MYPATH/$1 >>$MYPATH/tmp/$1_tmp/$1.txt.html
 echo "</body></html>" >> $MYPATH/tmp/$1_tmp/$1.txt.html

 cp $MYPATH/$1 $MYPATH/tmp/$1_tmp/
 sh $HOME_anu_test/shell_scripts/frame.sh $1 $MYPATH/tmp/$1_tmp/

  mkdir $MYPATH/tmp/$1_tmp/anu_html
  cp $HOME_anu_test/Browser/img.php $HOME_anu_test/Browser/val.js $MYPATH/tmp/$1_tmp/anu_html/
 
  cp *.html  $MYPATH1/. 
  cd $HOME_anu_test/Browser
  cp -r help/*htm $MYPATH1/help/
  cd src
  cp *.html *.js *.css $MYPATH1

	#To add slashes before(',",(,) etc.. )  inside initialise function(used for google api)

	cd $MYPATH1
	perl $HOME_anu_test/Anu_src/change-html-remove-title.pl < $1.html > $1-new.html
	cp $1.html $1-old.html
	cp $1-new.html $1.html
