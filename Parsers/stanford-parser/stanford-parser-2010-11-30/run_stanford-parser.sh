  ./run_stanford.sh $2/tmp/$1_tmp/one_sentence_per_line.txt 1>$2/tmp/$1_tmp/sd-relations-cat_tmp.txt 2>$2/tmp/$1_tmp/sd-sent.txt
    sh run_lexicalize.sh $2/tmp/$1_tmp/one_sentence_per_line.txt 1>$2/tmp/$1_tmp/sd-lexicalize_info_tmp.txt 2>/dev/null
  ./add_pattern.out <$2/tmp/$1_tmp/sd-lexicalize_info_tmp.txt > $2/tmp/$1_tmp/sd-lexicalize_info.txt
  ./sd-original-info.out  < $2/tmp/$1_tmp/sd-relations-cat_tmp.txt  > $2/tmp/$1_tmp/sd-user-relations-cat.txt 
  python split-basic-propagation-tree_rels.py $2/tmp/$1_tmp/sd-relations-cat_tmp.txt  $2/tmp/$1_tmp/sd-basic_relations_tmp.txt $2/tmp/$1_tmp/sd-propagation_relations_tmp.txt $2/tmp/$1_tmp/sd-tree_relations_tmp.txt
  ./stnford_relations.out $2/tmp/$1_tmp/sd-tree_relation.txt rel_name-sids < $2/tmp/$1_tmp/sd-tree_relations_tmp.txt
  ./stnford_relations.out $2/tmp/$1_tmp/sd-propagation_relations.txt propogation_rel_name-sids < $2/tmp/$1_tmp/sd-propagation_relations_tmp.txt
  ./stnford_relations.out $2/tmp/$1_tmp/sd-basic_relation.txt basic_rel_name-sids < $2/tmp/$1_tmp/sd-basic_relations_tmp.txt
  ./stnford_word.out $2/tmp/$1_tmp/sd_word.txt $2/tmp/$1_tmp/sd_numeric_word.txt < $2/tmp/$1_tmp/sd-sent.txt 
  rm $2/tmp/$1_tmp/sd-sent.txt
  python sd_category.py $2/tmp/$1_tmp/sd-relations-cat_tmp.txt  $2/tmp/$1_tmp/sd_category.txt
  rm $2/tmp/$1_tmp/sd-relations-cat_tmp.txt
