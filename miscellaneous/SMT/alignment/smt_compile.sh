rm *.out  
rm $HOME_anu_test/Anu_databases/Physics-dictionary.gdbm
rm $HOME_anu_test/Anu_databases/provisional_PropN_dic.gdbm
rm $HOME_anu_test/Anu_databases/provisional_word_dic.gdbm
rm $HOME_anu_test/Anu_databases/provisional_root_dic.gdbm

cd $HOME_anu_test/Anu_data
echo "Creating Physics-dictionary"
 ./create-gdbm.pl $HOME_anu_test/Anu_databases/Physics-dictionary.gdbm < $HOME_anu_test/miscellaneous/SMT/alignment/dictionaries/Physics-dictionary.txt
echo "Creating provisional_PropN_dictionary"
 ./create-gdbm.pl $HOME_anu_test/Anu_databases/provisional_PropN_dic.gdbm < $HOME_anu_test/miscellaneous/SMT/alignment/dictionaries/provisional_PropN_dic.txt
echo "Creating provisional_word_dictionary"
 ./create-gdbm.pl $HOME_anu_test/Anu_databases/provisional_word_dic.gdbm < $HOME_anu_test/miscellaneous/SMT/alignment/dictionaries/provisional_word_dic.txt
echo "Creating provisional_root_dictionary"
 ./create-gdbm.pl $HOME_anu_test/Anu_databases/provisional_root_dic.gdbm < $HOME_anu_test/miscellaneous/SMT/alignment/dictionaries/provisional_root_dic.txt
echo "Creating Science-dictionary"
./create-gdbm.pl $HOME_anu_test/Anu_databases/Science-dictionary.gdbm < $HOME_anu_test/miscellaneous/SMT/alignment/dictionaries/Science-dictionary.txt

cd $HOME_anu_test/miscellaneous/SMT/alignment
echo "generating out file"
$HOME_anu_test/Anu_src/comp.sh get_tam_info


