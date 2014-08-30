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
 STANFORD_PATH=$HOME_anu_test/Parsers/stanford-parser/stanford-parser-full-2014-08-27
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

 PRES_PATH=`pwd`
 cp $1 $MYPATH/tmp/$1_tmp/
 ###Added below loop for server purpose.
 if [ "$3" == "True" ] ; then 
    echo "" > $MYPATH/tmp/$1_tmp/sand_box.dat
    cd $HOME_anu_provisional_wsd_rules
    sh get_canonical_form_prov_wsd_rules.sh 
 else
    echo "(not_SandBox)"  > $MYPATH/tmp/$1_tmp/sand_box.dat
 fi

 #running stanford NER (Named Entity Recogniser) on whole text.
 echo "Calling NER ..."
 cd $HOME_anu_test/Parsers/stanford-parser/stanford-ner-2013-06-20/
 sh run-ner.sh $1



 cd $PRES_PATH
 echo "Saving Format info ..."

 $HOME_anu_test/Anu/ol_stdenglish.sh $1 $MYPATH $5
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

  cd $HOME_anu_test/Anu_src
  ./aper_chunker.out $MYPATH/tmp/$1_tmp/chunk.txt < $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.chunker

  echo "Calling Link Parser"
  cd $HOME_anu_test/Parsers/LINK/link-grammar-4.5.7/link-grammar
  ./link-parser $HOME_anu_test/Parsers/LINK/link-grammar-4.5.7/data/en $MYPATH/tmp $1 $2 <$MYPATH/tmp/$1_tmp/one_sentence_per_line.txt
 
  replace-abbrevations.sh $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt  $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tmp_org
  cd $HOME_anu_test/Anu_src/
  ./replace_nonascii-chars.out $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tmp_org $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_org

  echo "Calling Stanford parser ..."
  cd $HOME_anu_test/Parsers/stanford-parser/src
  if [ "$2" != "" -a "$2" != "0" ] ;
  then
  sh run_multiple_parse_penn.sh $STANFORD_PATH $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_org > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp_1 2>/dev/null  
  python preffered_parse.py $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp_1 $2 > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp 2>/dev/null
  else 
  sh run_penn-pcfg.sh $STANFORD_PATH  $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_org > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp 2>/dev/null
  fi
  sed -n -e "H;\${g;s/Sentence skipped: no PCFG fallback.\nSENTENCE_SKIPPED_OR_UNPARSABLE/(ROOT (S ))\n/g;p}"  $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp  > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.std.penn_tmp1
  sh run_stanford-parser.sh $STANFORD_PATH $1 $MYPATH > /dev/null

  echo "Tokenizing ..." 
  perl $HOME_anu_test/miscellaneous/HANDY_SCRIPTS/tokenizer.perl -l en < $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt | sed "s/ 's /'s /g" | sed "s/s ' /s' /g" > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised

  echo "Multi word ..."
  $HOME_anu_test/multifast-v1.0.0/src/multi_word_expression $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised > $MYPATH/tmp/$1_tmp/multi_word_expressions.txt
  $HOME_anu_test/multifast-v1.0.0/src/multi_word_expression_for_proper_nouns $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised > $MYPATH/tmp/$1_tmp/proper_noun_dic.txt
  if [ "$3" == "True" ]; then
	  $HOME_anu_test/multifast-v1.0.0/src/multi_word_expression_for_prov $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised > $MYPATH/tmp/$1_tmp/provisional_multi_dic.txt
  fi

  if [ "$4" == "physics" ]; then 
     $HOME_anu_test/multifast-v1.0.0/src/multi_word_expression_for_physics $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tokenised > $MYPATH/tmp/$1_tmp/phy_multi_word_expressions.txt
  fi
 
  echo "Calling OPEN-LOGOS"
  cd $HOME_anu_test/Anu_src
  python transform_words.py $HOME_anu_tmp/tmp/$1_tmp/one_sentence_per_line.txt $HOME_anu_test/Anu_data/transformed_words.txt $HOME_anu_tmp/tmp/$1_tmp/one_sentence_per_line_changed.txt $HOME_anu_tmp/tmp/$1_tmp/transformed_word_id_all.dat

  cd $HOME_open_logos/testapi
  cp testolgs.sh TransL_JobControlArguments apitest_settings.txt $HOME_anu_tmp/
  cd $HOME_anu_tmp
  sed 's/ABBRDOT/./g' $MYPATH/tmp/$1_tmp/one_sentence_per_line_changed.txt > $MYPATH/tmp/$1_tmp/one_sentence_per_line_changed.txt_tmp  #Ex: He was called simply Clint Jr. because his Daddy was Clint Sr.. 
  mv $MYPATH/tmp/$1_tmp/one_sentence_per_line_changed.txt_tmp  $MYPATH/tmp/$1_tmp/one_sentence_per_line_changed.txt
  cp $MYPATH/tmp/$1_tmp/one_sentence_per_line_changed.txt   $HOME_anu_tmp/apitest.input
  sh testolgs.sh >/dev/null
  cp apitest.input-EG-TR.diag $MYPATH/tmp/$1_tmp/one_sentence_per_line-diag.txt 

  cd $MYPATH/tmp/$1_tmp
  sed 's/&/\&amp;/g' one_sentence_per_line.txt|sed -e s/\'/\\\'/g |sed 's/\"/\&quot;/g' |sed  "s/^/(Eng_sen \"/" |sed -n '1h;2,$H;${g;s/\n/\")\n;~~~~~~~~~~\n/g;p}'|sed -n '1h;2,$H;${g;s/$/\")\n;~~~~~~~~~~\n/g;p}' > one_sentence_per_line_tmp.txt
  $HOME_anu_test/Anu_src/split_file.out one_sentence_per_line_tmp.txt dir_names.txt English_sentence.dat
  $HOME_anu_test/Anu_src/split_file.out link_relation_info.txt dir_names.txt link_relation_info_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out link_name_expand.txt dir_names.txt link_name_expand.dat
  $HOME_anu_test/Anu_src/split_file.out linkid_word.txt dir_names.txt linkid_word_tmp.dat
 #$HOME_anu_test/Anu_src/split_file.out linkid_cat.txt dir_names.txt linkid_cat_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out link_numeric_word.txt dir_names.txt link_numeric_word_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out linkage_count.txt dir_names.txt linkage_count
  $HOME_anu_test/Anu_src/split_file.out chunk.txt dir_names.txt chunk.dat 
 #  $HOME_anu_test/Anu_src/split_file.out sd-relation.txt dir_names.txt sd-relations_tmp.dat
   $HOME_anu_test/Anu_src/split_file.out sd-tree_relation.txt dir_names.txt sd-tree_relations_tmp.dat
   $HOME_anu_test/Anu_src/split_file.out sd-basic_relation.txt dir_names.txt sd-basic_relations_tmp1.dat
   $HOME_anu_test/Anu_src/split_file.out sd-propagation_relations.txt dir_names.txt sd-propagation_relations_tmp1.dat
   $HOME_anu_test/Anu_src/split_file.out sd_word.txt dir_names.txt sd_word_tmp.dat
   $HOME_anu_test/Anu_src/split_file.out sd_numeric_word.txt dir_names.txt sd_numeric_word_tmp.dat
   $HOME_anu_test/Anu_src/split_file.out sd_category.txt dir_names.txt sd_category.dat
   perl  $HOME_anu_test/Anu_src/pre-split.pl < $MYPATH/tmp/$1_tmp/one_sentence_per_line-diag.txt   >tmp1
   $HOME_anu_test/Anu_src/split_file.out one_sentence_per_line.txt.ner dir_names.txt ner.dat
 
  $HOME_anu_test/Anu_src/split_file.out tmp1  dir_names.txt ol-EG-TR.diag
  $HOME_anu_test/Anu_src/split_file.out $HOME_anu_tmp/tmp/$1_tmp/transformed_word_id_all.dat  dir_names.txt transformed_word_id.dat
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
 
 #check and run all the parsers (ol,link,stanford)
 
 while read line
 do
 	python $HOME_anu_test/Anu_src/check_ol_failure.py $MYPATH/tmp/$1_tmp/$line/ol-EG-TR.diag $MYPATH/tmp/$1_tmp/$line/ol_status.txt
 	while read line1
 	do
 		echo "$line1" | grep -q 'failed' 
 		if [[ $? -eq 0 ]] ;
 		then
 			while read line2
 			do
 				echo "$line2" | grep -q 'of 0 linkages'
 				if [[ $? -eq 0 ]] ;
				then
					echo "Hindi meaning using Stanford parser" $line
					cp $MYPATH/tmp/$1_tmp/sand_box.dat $MYPATH/tmp/$1_tmp/$line/										
    					cp $MYPATH/tmp/$1_tmp/ner.txt $MYPATH/tmp/$1_tmp/$line/ner.dat
 					timeout 180 ./run_sentence_stanford.sh $1 $line 1 $MYPATH $4
 					echo ""
				else
 					echo "Hindi meaning using Link parser" $line
					cp $MYPATH/tmp/$1_tmp/sand_box.dat $MYPATH/tmp/$1_tmp/$line/
    					cp $MYPATH/tmp/$1_tmp/ner.txt $MYPATH/tmp/$1_tmp/$line/ner.dat
 					timeout 180 ./run_sentence_link.sh $1 $line 1 $MYPATH $4
 					echo ""
 								fi
 			done < $HOME_anu_tmp/tmp/$1_tmp/$line/linkage_count
 
 		else
 			echo "Hindi meaning using Open Logos" $line
			cp $MYPATH/tmp/$1_tmp/sand_box.dat $MYPATH/tmp/$1_tmp/$line/
    			cp $MYPATH/tmp/$1_tmp/ner.txt $MYPATH/tmp/$1_tmp/$line/ner.dat
			timeout 180 ./run_sentence_ol.sh $1 $line 1 $MYPATH $4
			echo ""
		fi
 		done < $HOME_anu_tmp/tmp/$1_tmp/$line/ol_status.txt
 done < $MYPATH/tmp/$1_tmp/dir_names.txt

 echo "Calling Transliteration"
 cd $HOME_anu_test/miscellaneous/transliteration/work
 sh run_transliteration.sh $MYPATH/tmp $1

 cd $MYPATH/tmp/$1_tmp/
 echo "(defglobal ?*path* = $HOME_anu_test)" > path_for_html.clp
 echo "(defglobal ?*mypath* = $MYPATH)" >> path_for_html.clp
 echo "(defglobal ?*filename* = $1)" >> path_for_html.clp

 echo "Calling Interface related programs"
 sh $HOME_anu_test/bin/run_anu_browser.sh $HOME_anu_test $1 $MYPATH $HOME_anu_output
