rm *.out
rm $HOME_anu_test/Anu_databases/Physics-dictionary.gdbm
rm $HOME_anu_test/Anu_databases/provisional_PropN_dic.gdbm
rm $HOME_anu_test/Anu_databases/provisional_word_dic.gdbm
rm $HOME_anu_test/Anu_databases/provisional_root_dic.gdbm
rm $HOME_anu_test/Anu_databases/Science-dictionary.gdbm
rm $HOME_anu_test/Anu_databases/hindi_tam_dictionary.gdbm
rm $HOME_anu_test/Anu_databases/preposition_dictionary.gdbm
rm $HOME_anu_test/Anu_databases/hindi_wordnet_dic1.gdbm
rm $HOME_anu_test/Anu_databases/hindi_wordnet_dic2.gdbm
rm $HOME_anu_test/Anu_databases/restricted_eng_words.gdbm
rm $HOME_anu_test/Anu_databases/restricted_hnd_words.gdbm
rm $HOME_anu_test/Anu_databases/numbers_dic.gdbm

cd $HOME_anu_test/Anu_data/canonical_form_dictionary/
sh get_txt_files.sh
sh get_dictionary_in_canonical_form.sh


cd $HOME_anu_test/Anu_data
echo "Creating Physics-dictionary"
 ./create-gdbm.pl $HOME_anu_test/Anu_databases/Physics-dictionary.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/Physics-dictionary_in_canonical_form.txt
echo "Creating provisional_PropN_dictionary"
 ./create-gdbm.pl $HOME_anu_test/Anu_databases/provisional_PropN_dic.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/provisional_PropN_dic_in_canonical_form.txt
echo "Creating provisional_word_dictionary"
 ./create-gdbm.pl $HOME_anu_test/Anu_databases/provisional_word_dic.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/provisional_word_dic_in_canonical_form.txt
echo "Creating provisional_root_dictionary"
 ./create-gdbm.pl $HOME_anu_test/Anu_databases/provisional_root_dic.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/provisional_root_dic_in_canonical_form.txt
echo "Creating Science-dictionary"
./create-gdbm.pl $HOME_anu_test/Anu_databases/Science-dictionary.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/Science-dictionary_in_canonical_form.txt
echo "Creating hindi_tam_dictionary"
./create-gdbm.pl $HOME_anu_test/Anu_databases/hindi_tam_dictionary.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/hindi_tam_dictionary_in_canonical_form.txt
echo "Creating preposition_dictionary"
./create-gdbm.pl $HOME_anu_test/Anu_databases/preposition_dictionary.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/preposition_dictionary_in_canonical_form.txt
echo "Creating Hindi Wordnet dictionaries"
./create-gdbm.pl $HOME_anu_test/Anu_databases/hindi_wordnet_dic1.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/hindi_wordnet_dic1_in_canonical_form.txt
./create-gdbm.pl $HOME_anu_test/Anu_databases/hindi_wordnet_dic2.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/hindi_wordnet_dic2_in_canonical_form.txt
echo "Creating Hindi_multi_word dictionary"
./create-gdbm.pl $HOME_anu_test/Anu_databases/hindi_multi_word.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/hindi_multi_word_in_canonical_form.txt
echo "Creating restricted_eng_words dictionary"
./create-gdbm.pl $HOME_anu_test/Anu_databases/restricted_eng_words.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/restricted_eng_words_in_canonical_form.txt
echo "Creating restricted_hnd_words dictionary"
./create-gdbm.pl $HOME_anu_test/Anu_databases/restricted_hnd_words.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/restricted_hnd_words_in_canonical_form.txt
echo "Creating numbers dictionary"
./create-gdbm.pl $HOME_anu_test/Anu_databases/numbers_dic.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/numbers_dic_in_canonical_form.txt


 echo "Creating multi_word_expressions.gdbm"
 ./create-gdbm.pl $HOME_anu_test/Anu_databases/multi_word_expressions.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/multi_word_expressions_in_canonical_form.txt
 echo "Creating default-iit-bombay-shabdanjali-dic.gdbm"
 ./create-gdbm.pl $HOME_anu_test/Anu_databases/default-iit-bombay-shabdanjali-dic.gdbm < $HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries/default-iit-bombay-shabdanjali-dic_in_canonical_form.txt

cd $HOME_anu_test/miscellaneous/SMT/MINION/alignment
echo "Compiling minion files"
gcc -o line_count.out line_count.c
$HOME_anu_test/Anu_src/comp.sh $HOME_anu_test/miscellaneous/SMT/alignment/morph
$HOME_anu_test/Anu_src/comp.sh $HOME_anu_test/miscellaneous/SMT/alignment/get_tam_info
gcc -o $HOME_anu_test/miscellaneous/SMT/alignment/replace_wrd_with_id.out $HOME_anu_test/miscellaneous/SMT/alignment/replace_wrd_with_id.c

cd $HOME_anu_test/miscellaneous/SHALLOW_PARSER
sh compile_shallow_parser.sh
