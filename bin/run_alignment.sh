 cd $1
 
 sh $HOME_anu_test/miscellaneous/SMT/phrasal_alignment/convert_transliterate_file_to_fact_format.sh ../transliterated_words_list > transliterated_words_list.dat 

 myclips -f $HOME_anu_test/miscellaneous/SMT/phrasal_alignment/run_H_gen_sen_eng.bat >> $1.error

 cat  para_sent_id_info.dat original_word.dat word.dat punctuation_info.dat sd_chunk.dat cat_consistency_check.dat padasuthra.dat root.dat  revised_preferred_morph.dat lwg_info.dat hindi_meanings_with_grp_ids.dat GNP_agmt_info.dat id_Apertium_output.dat catastrophe.dat  > facts_for_eng_html

 sed "s/position-eng-hnd-eng_ids/position_hi_en-eng-hnd-eng_ids/g" mapped3-hi-en.dat > mapped3-hi-en1.dat
 cat facts_for_eng_html English_sentence.dat word-alignment.dat word-alignment-hi-en.dat word_alignment.dat manual_hindi_sen.dat mapped3.dat mapped3-hi-en1.dat >> facts_for_eng_align_html
