######## Convert canonical form multi word dictionaries to multifast dictionary format

MYPATH=$HOME_anu_test/Anu_data/canonical_form_dictionary/dictionaries

gcc -o get_word_count get_word_count.c
cat $MYPATH/proper_noun-common_noun_compounds_in_canonical_form.txt $MYPATH/acronyms-common_noun_compounds_in_canonical_form.txt $MYPATH/named_entities_in_canonical_form.txt > proper_noun_dic.txt

sh get_multi_word-dic.sh $MYPATH/multi_word_expressions_in_canonical_form.txt   multi_word-dic.c
sh get_multi_word-dic.sh proper_noun_dic.txt     proper_noun-dic.c
sh get_multi_word-dic.sh $MYPATH/phy_eng_multi_word_dic_in_canonical_form.txt   physics-dic.c

rm proper_noun_dic.txt
