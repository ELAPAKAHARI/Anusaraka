 
 ./rasp.sh -p'-ou -u ' < $3 >$3_rasp_output
 sed -n -e "H;\${g;s/\nupenn: 1/upenn: 1/g;p}" < $3_rasp_output | sed 's/.*upenn: 1$//g' |sed -n -e "H;\${g;s/\n//g;p}" |sed -n -e "H;\${g;s/(TOP/\n(ROOT/g;p}" |sed -n "s/^$//;t;p;" | sed 's/[ ]*(/ (/g' | sed 's/^ (/(/g'> $3_rasp_cons_tmp
 ./eng_aper_gen.out < $3_rasp_cons_tmp > $3_rasp_aper_cons_analysis
 lt-proc -c -g $HOME_anu_test/apertium/en.gen.bin <$3_rasp_aper_cons_analysis >$1_rasp_aper_cons_gen 
 
 cd $1/tmp/$2_tmp
 $HOME_anu_test/Anu_src/split_file.out $3_rasp_aper_cons_gen $1/tmp/$2_tmp/dir_names.txt rasp_constituents

 while read line
 do
 cd $line
 sh $HOME_anu_test/Parsers/RASP/rasp3os/scripts/constituency_parse rasp_constituents_info.dat rasp_node_category.dat < rasp_constituents
 myclips -f $HOME_anu_test/Anu_clp_files/add_labels.clp >  $1.error
 myclips -f $HOME_anu_test/Anu_clp_files/get_rasp_constituency_tree.clp >  $1.error
 sed  's/LB /(/g' $line/constituency_tree_tmp.dat |sed 's/RB)$/)/g' |sed 's/RB /)/g' | sed 's/(Cons-tree //g' |sed 's/\((\)\([A-Z$0-9]*\)\([-]\)\([0-9]*\)/\1\2/g' > $line/constituency_tree.dat
 cat $line/constituency_tree.dat $line/$1_rasp_mapped_cons
 done < $1/tmp/$2_tmp/dir_names.txt
