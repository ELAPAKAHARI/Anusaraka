MYPATH=$HOME_anu_tmp
echo "extracting keys from hindi sentence"
$HOME_anu_test/multifast-v1.0.0/src/extract_key_using_multifast-hi-en $1 $MYPATH/tmp/$3_tmp/map-hi-en.txt > $MYPATH/tmp/$3_tmp/key-hi-en.txt 
echo "extracting values for the given keys"
./gdbm-fetch.out  hi-en/Hin-Eng-dic.gdbm  $MYPATH/tmp/$3_tmp/key-hi-en.txt > $MYPATH/tmp/$3_tmp/key-val-hi-en.txt
echo "searching values in english sentence"
python match_value_in_hnd.py  $2  $MYPATH/tmp/$3_tmp/key-val-hi-en.txt $MYPATH/tmp/$3_tmp/graph_input-hi-en $1 $MYPATH/tmp/$3_tmp/graph_output-hi-en> $MYPATH/tmp/$3_tmp/match-value-hi-en.txt 
echo "Phrase alignment"
python print_shortest_path.py $MYPATH/tmp/$3_tmp/match-value-hi-en.txt  $MYPATH/tmp/$3_tmp/graph_output-hi-en > $MYPATH/tmp/$3_tmp/shortest-path-value-hi-en.txt
python count.py $MYPATH/tmp/$3_tmp/shortest-path-value-hi-en.txt $MYPATH/tmp/$3_tmp/ $MYPATH/tmp/$3_tmp/count_dict_with_length-hi-en.txt
sh split.sh $MYPATH/tmp/$3_tmp/count_dict_with_length-hi-en.txt
sh sort.sh $MYPATH/tmp/$3_tmp/sorted_file-hi-en.txt
python get_phrase.py  $2  $MYPATH/tmp/$3_tmp/sorted_file-hi-en.txt $MYPATH/tmp/$3_tmp/shortest-path-value-hi-en.txt $MYPATH/tmp/$3_tmp/left-over-words-hi-en.txt > $MYPATH/tmp/$3_tmp/align_eng-hi-en.txt
python map-ids.py  $MYPATH/tmp/$3_tmp/align_eng-hi-en.txt  $MYPATH/tmp/$3_tmp/map-hi-en.txt $MYPATH/tmp/$3_tmp/mapped-hi-en.txt
echo "Word alignment"
python get_word_align.py hi-en/Word-to-word-hi-en.txt   $MYPATH/tmp/$3_tmp/mapped-hi-en.txt $2 $MYPATH/tmp/$3_tmp/left-hi-en > $MYPATH/tmp/$3_tmp/wrd-to-wrd-hi-en.txt1
echo "Aligning left over words"
sh split.sh $MYPATH/tmp/$3_tmp/wrd-to-wrd-hi-en.txt1
sh hi-en/align-hi-en.sh $MYPATH/tmp/$3_tmp 
python mapping.py $MYPATH/tmp/$3_tmp/wrd-to-wrd-hi-en.txt > $MYPATH/tmp/$3_tmp/mapped-hi-en.txt1

#===================================== Mapping punctuations in alignment ===========================================
./replace-punctuation.out < $MYPATH/tmp/$3_tmp/mapped-hi-en.txt1  > $MYPATH/tmp/$3_tmp/mapped-hi-en.txt2


sed 's/\([0-9]\)[.]\([0-9]\)/\1SYMBOL-DOT\2/g'   $MYPATH/tmp/$3_tmp/mapped-hi-en.txt2  | sed 's/SYMBOL/@SYMBOL/g' | sed 's/PUNCT-/@PUNCT-/g' | sed 's/(anu_id-anu_mng-man_mng/(eng_id-eng_wrd-man_wrd/g'  > $MYPATH/tmp/$3_tmp/word-alignment-hi-en.txt

