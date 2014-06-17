#/bin/sh
 source ~/.bashrc

 export LC_ALL=
 export LC_ALL=en_US.UTF-8

 if ! [ -d $HOME_anu_tmp ] ; then
     echo $HOME_anu_tmp " directory does not exist "
     echo "Creating "$HOME_anu_tmp 
     mkdir $HOME_anu_tmp
 fi

 if ! [ -d $HOME_anu_output ] ; then
     echo $HOME_anu_output " directory does not exist "
     echo "Creating "$HOME_anu_output 
    mkdir $HOME_anu_output
 fi

 MYPATH=$HOME_anu_tmp
 cp $1 $MYPATH/. 

 if ! [ -d $MYPATH/tmp ] ; then
    echo "tmp  does not exist "
    echo " Creating tmp "
    mkdir $MYPATH/tmp
 fi

 if ! [ -d $HOME_anu_output/help ] ; then
    echo "help dir  does not exist "
    echo "Creating help dir"
    mkdir $HOME_anu_output/help
 fi

 if  [ -e $MYPATH/tmp/$1_tmp ] ; then
    rm -rf $MYPATH/tmp/$1_tmp
 fi

 mkdir $MYPATH/tmp/$1_tmp

 ###Added below loop for server purpose.
 if [ "$3" == "True" ] ; then 
    echo "" > $MYPATH/tmp/$1_tmp/sand_box.dat
 else
    echo "(not_SandBox)"  > $MYPATH/tmp/$1_tmp/sand_box.dat
 fi

 PRES_PATH=`pwd`
 if [ $# == 6 ] ; then 
	 cp $1 $MYPATH/tmp/$1_tmp/
	 cp $6 $MYPATH/tmp/$1_tmp/
 else
	echo "Check Arguments"
	exit
 fi
 #running stanford NER (Named Entity Recogniser) on whole text.
 echo "Calling NER ..."
 cd $HOME_anu_test/Parsers/stanford-parser/stanford-ner-2013-06-20/
 sh run-ner.sh $1

 echo "Calling Transliteration"
 cd $HOME_anu_test/miscellaneous/transliteration/work
 sh run_transliteration_for_minion.sh $MYPATH/tmp $1


 cd $PRES_PATH
 echo "Saving Format info ..."

 $HOME_anu_test/Anu/stdenglish.sh $1 $MYPATH $5
 $HOME_anu_test/Anu/pre_process.sh $1 $MYPATH $5
 $HOME_anu_test/Anu/save_format.sh $1 $MYPATH

 echo "Saving word information"
 cd $HOME_anu_test/Anu_src
 ./word.out < $MYPATH/tmp/tmp_save_format/$1.fmt_split $MYPATH/tmp $1
 ./rm_tags.out < $MYPATH/tmp/$1_tmp/new_text.txt > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt

  echo "Saving morph information"
  cd $HOME_anu_test/apertium/
  sed 's/\([^0-9.]\)\.\([^0-9.]*\)/\1 \.\2/g'  $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt | sed 's/?/ ?/g'| sed 's/\"/\" /g'  | sed 's/!/ !/g' > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tmp
  apertium-destxt $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tmp  | lt-proc -a en.morf.bin | apertium-retxt | sed "s/\$\^\([^'s]\)/\$ \^\1/g" > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.morph
  perl morph.pl $MYPATH $1 < $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.morph

  echo "Calling POS Tagger and Chunker (APERTIUM)" 
  cd $HOME_anu_test/apertium
  sh run_chunker_and_tagger.sh $1

  replace-abbrevations.sh $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt  $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tmp_org
  cd $HOME_anu_test/Anu_src/
  ./replace_nonascii-chars.out $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tmp_org $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_org

  echo "Calling Stanford parser ..."
  cd $HOME_anu_test/Parsers/stanford-parser/stanford-parser-full-2014-01-04/
  if [ "$2" != "" -a "$2" != "0" ] ;
  then
  sh run_multiple_parse_penn.sh $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_org > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp_1 2>/dev/null  
  python preffered_parse.py $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp_1 $2 > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp 2>/dev/null
  else 
  sh run_penn-pcfg.sh $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_org > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp 2>/dev/null
  fi
  sed -n -e "H;\${g;s/Sentence skipped: no PCFG fallback.\nSENTENCE_SKIPPED_OR_UNPARSABLE/(ROOT (S ))\n/g;p}"  $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp  > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp1
  sh run_stanford-parser.sh $1 $MYPATH > /dev/null

  echo "Tokenizing ..." 
  perl $HOME_anu_test/miscellaneous/HANDY_SCRIPTS/tokenizer.perl -l en < $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt | sed "s/ 's /'s /g" | sed "s/s ' /s' /g" > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised
  perl $HOME_anu_test/miscellaneous/HANDY_SCRIPTS/tokenizer.perl -l en < $MYPATH/tmp/$1_tmp/$6 | sed "s/ 's /'s /g" | sed "s/s ' /s' /g" | sed 's/ @ / @/g' > $MYPATH/tmp/$1_tmp/hnd-hi-en
  $HOME_anu_test/Anu_src/identify-nonascii-chars.out $MYPATH/tmp/$1_tmp/$6 $MYPATH/tmp/$1_tmp/hnd1
#  perl $HOME_anu_test/miscellaneous/HANDY_SCRIPTS/tokenizer.perl -l en < $MYPATH/tmp/$1_tmp/hnd1 | sed "s/ 's /'s /g" | sed "s/s ' /s' /g" | sed 's/ /_/g' | sed 's/^/_/g' | sed 's/_@_/_@/g' > $MYPATH/tmp/$1_tmp/hnd
  sed 's/^/_/g' $MYPATH/tmp/$1_tmp/hnd1 | sed 's/\([^ ]\),/\1 ,/g' | sed 's/\([^ ]\)(/\1 ( /g' | sed 's/\([^ ]\))/\1 )/g' |                      sed 's/\([^ ]\)?/\1 ?/g' | sed 's/\([^ ]\):/\1 :/g' |  sed 's/ /_/g' | sed 's/$/_/g' > $MYPATH/tmp/$1_tmp/hnd

  echo "Multi word ..."
  $HOME_anu_test/multifast-v1.0.0/src/multi_word_expression $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised > $MYPATH/tmp/$1_tmp/multi_word_expressions.txt
  $HOME_anu_test/multifast-v1.0.0/src/multi_word_expression_for_proper_nouns $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised > $MYPATH/tmp/$1_tmp/proper_noun_dic.txt
  if [ "$3" == "True" ]; then
	  $HOME_anu_test/multifast-v1.0.0/src/multi_word_expression_for_prov $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised > $MYPATH/tmp/$1_tmp/provisional_multi_dic.txt
  fi

  if [ "$4" == "physics" ]; then 
     $HOME_anu_test/multifast-v1.0.0/src/multi_word_expression_for_physics $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised > $MYPATH/tmp/$1_tmp/phy_multi_word_expressions.txt
  fi

  #====================================== Alignment through phrasal ================================================
  echo "Alignment through phrasal ..."
  cd $HOME_anu_test/miscellaneous/SMT/phrasal_alignment
  replace-abbrevations.sh $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised  $MYPATH/tmp/$1_tmp/eng_tmp_tok_org
  $HOME_anu_test/Anu/stdenglish/replace-mapping-symbols.out < $MYPATH/tmp/$1_tmp/eng_tmp_tok_org > $MYPATH/tmp/$1_tmp/eng_tok_org
 # sed -i 's/\([^ ]\)$/\1 /g'  $MYPATH/tmp/$1_tmp/eng_tok_org
#  perl $HOME_anu_test/miscellaneous/HANDY_SCRIPTS/tokenizer.perl -l en < $MYPATH/tmp/$1_tmp/eng_tmp2_tok_org | sed "s/ 's /'s /g" | sed "s/s ' /s' /g" > $MYPATH/tmp/$1_tmp/eng_tok_org
 sed 's/^/_/g' $MYPATH/tmp/$1_tmp/eng_tok_org | sed 's/ /_/g' > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised1

  sh run_alignment.sh $MYPATH/tmp/$1_tmp/eng_tok_org $MYPATH/tmp/$1_tmp/hnd $1 
  echo "Alignment through hindi in eng order ..."
  sh run_alignment-hi-en.sh $MYPATH/tmp/$1_tmp/eng_tok_org $MYPATH/tmp/$1_tmp/hnd $1
  echo "Alignment through hindi order ..." 
  sh run_alignment-hi-en-hi.sh $MYPATH/tmp/$1_tmp/hnd-hi-en $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised1 $1 
 

  cd $MYPATH/tmp/$1_tmp
  $HOME_anu_test/Anu_src/split_file.out one_sen_per_line_manual_hindi_sen.txt dir_names.txt manual_hindi_sen.dat
#  $HOME_anu_test/Anu_src/split_file.out  $MYPATH/tmp/$1_tmp/count_dict.txt dir_names.txt count_dict.dat
  
  $HOME_anu_test/Anu_src/split_file.out  $MYPATH/tmp/$1_tmp/word-alignment.txt dir_names.txt word-alignment.dat
  $HOME_anu_test/Anu_src/split_file.out  $MYPATH/tmp/$1_tmp/word-alignment-hi-en.txt dir_names.txt word-alignment-hi-en.dat
  $HOME_anu_test/Anu_src/split_file.out  $MYPATH/tmp/$1_tmp/word-alignment-hi-en-hi.txt dir_names.txt word-alignment-hi-en-hi.dat
  wx_utf8 < $MYPATH/tmp/$1_tmp/align_left_over_wrds.txt > align_left_over_wrds.txt1
  $HOME_anu_test/Anu_src/split_file.out  $MYPATH/tmp/$1_tmp/align_left_over_wrds.txt1 dir_names.txt align_left_over_wrds.dat
  
  #=================================================================================================================

  sed 's/&/\&amp;/g' one_sentence_per_line.txt|sed -e s/\'/\\\'/g |sed 's/\"/\&quot;/g' |sed  "s/^/(Eng_sen \"/" |sed -n '1h;2,$H;${g;s/\n/\")\n;~~~~~~~~~~\n/g;p}'|sed -n '1h;2,$H;${g;s/$/\")\n;~~~~~~~~~~\n/g;p}' > one_sentence_per_line_tmp.txt
  $HOME_anu_test/Anu_src/split_file.out one_sentence_per_line_tmp.txt dir_names.txt English_sentence.dat
  $HOME_anu_test/Anu_src/split_file.out sd-lexicalize_info.txt dir_names.txt sd-lexicalize_info.dat
  $HOME_anu_test/Anu_src/split_file.out sd-tree_relation.txt dir_names.txt sd-tree_relations_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out sd-basic_relation.txt dir_names.txt sd-basic_relations_tmp1.dat
  $HOME_anu_test/Anu_src/split_file.out sd-propagation_relations.txt dir_names.txt sd-propagation_relations_tmp1.dat
  $HOME_anu_test/Anu_src/split_file.out sd_word.txt dir_names.txt sd_word_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out sd_numeric_word.txt dir_names.txt sd_numeric_word_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out sd_category.txt dir_names.txt sd_category_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out sd-original-relations.txt  dir_names.txt  sd-original-relations.dat

  $HOME_anu_test/Anu_src/split_file.out multi_word_expressions.txt  dir_names.txt  multi_word_expressions.dat
  $HOME_anu_test/Anu_src/split_file.out proper_noun_dic.txt  dir_names.txt  proper_noun_dic.dat
  if [ "$3" == "True" ]; then
          $HOME_anu_test/Anu_src/split_file.out provisional_multi_dic.txt dir_names.txt provisional_multi_dic.dat
  fi

  if [ "$4" == "physics" ]; then
  $HOME_anu_test/Anu_src/split_file.out phy_multi_word_expressions.txt  dir_names.txt  phy_multi_word_expressions.dat
  fi
  grep -v '^$' $MYPATH/tmp/$1.snt  > $1.snt
  perl $HOME_anu_test/Anu_src/Match-sen.pl $HOME_anu_test/Anu_databases/Complete_sentence.gdbm  $1.snt one_sentence_per_line.txt > sen_phrase.txt

  $HOME_anu_test/Anu_src/split_file.out sen_phrase.txt dir_names.txt sen_phrase.dat
 
 cd $HOME_anu_test/bin
 while read line
 do
    echo "Hindi meaning using Stanford parser" $line
    cp $MYPATH/tmp/$1_tmp/sand_box.dat $MYPATH/tmp/$1_tmp/$line/
    cp $MYPATH/tmp/$1_tmp/ner.txt $MYPATH/tmp/$1_tmp/$line/ner.dat
    timeout 500 ./run_sentence_stanford_align_eng.sh $1 $line 1 $MYPATH $4 $6
    echo ""
 done < $MYPATH/tmp/$1_tmp/dir_names.txt


 cd $MYPATH/tmp/$1_tmp/
 echo "(defglobal ?*path* = $HOME_anu_test)" > path_for_html.clp
 echo "(defglobal ?*mypath* = $MYPATH)" >> path_for_html.clp
 echo "(defglobal ?*filename* = $1)" >> path_for_html.clp

 echo "Calling Interface related programs"
 sh $HOME_anu_test/bin/run_anu_browser.sh $HOME_anu_test $1 $MYPATH $HOME_anu_output
 sh $HOME_anu_test/miscellaneous/SMT/MINION/browser/run_align_browser_eng.sh $HOME_anu_test $1 $MYPATH $HOME_anu_output
