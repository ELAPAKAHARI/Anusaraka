 cd $HOME_anu_test/miscellaneous/SHALLOW_PARSER

 if  [ -e $HOME_anu_test/miscellaneous/SHALLOW_PARSER/shallow-parser-hin-3.0.fc8 ] ; then
     rm -rf shallow-parser-hin-3.0.fc8/
     rm -rf ~/sampark
 fi

 tar -xvzf shallow-parser-hin-3.0.fc8.tgz

 if  [ -e $HOME_anu_test/miscellaneous/SHALLOW_PARSER/fullparser-hin-1.6.3 ] ; then
     rm -rf fullparser-hin-1.6.3/
     rm -rf ~/sampark
 fi

 tar -xvzf fullparser-hin-1.6.3.tgz

 cd $HOME_anu_test/miscellaneous/SHALLOW_PARSER/shallow-parser-hin-3.0.fc8/bin/sl/
 mv old-morph/ old-morph-bkp/
 mv morph/ morph-bkp/
 cp -r old-morph-bkp/ morph

 cd $HOME_anu_test/miscellaneous/SHALLOW_PARSER/shallow-parser-hin-3.0.fc8/data_bin/sl
 mv old-morph/ old-morph-bkp/
 mv morph/ morph-bkp/
 cp -r old-morph-bkp/ morph

 cd $HOME_anu_test/miscellaneous/SHALLOW_PARSER/shallow-parser-hin-3.0.fc8
 make install

 echo "Full Parser Compilation:"
 cd $HOME_anu_test/miscellaneous/SHALLOW_PARSER/fullparser-hin-1.6.3
 make
 cd $setu/src/sl/fullparser_hin-1.6.3
 make install
