  ./run_berkeley.sh $2/tmp/$1_tmp/one_sentence_per_line.txt.berkeley 1>$2/tmp/$1_tmp/sd-relations-cat_tmp.txt 
  python split-berkeley-basic-tree-prop_rels.py $2/tmp/$1_tmp/sd-relations-cat_tmp.txt  $2/tmp/$1_tmp/sd-basic_relations_tmp.txt $2/tmp/$1_tmp/sd-propagation_relations_tmp.txt $2/tmp/$1_tmp/sd-tree_relations_tmp.txt 
 ./stnford_relations.out $2/tmp/$1_tmp/sd-tree_relation.txt rel_name-sids < $2/tmp/$1_tmp/sd-tree_relations_tmp.txt
 ./stnford_relations.out $2/tmp/$1_tmp/sd-basic_relation.txt basic_rel_name-sids < $2/tmp/$1_tmp/sd-basic_relations_tmp.txt
 ./stnford_relations.out $2/tmp/$1_tmp/sd-propagation_relations.txt propogation_rel_name-sids < $2/tmp/$1_tmp/sd-propagation_relations_tmp.txt
 ./berkeley_word_cat.out < $2/tmp/$1_tmp/one_sentence_per_line.txt.berkeley $2/tmp/$1_tmp/sd_numeric_word.txt $2/tmp/$1_tmp/sd_category.txt $2/tmp/$1_tmp/sd_word.txt

