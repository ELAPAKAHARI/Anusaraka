#!/bin/sh
#Modified this shell by Roja(08-06-2013)
scriptdir=`dirname $0`

java -mx700m -cp "$scriptdir/stanford-ner.jar:" edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier classifiers/english.all.3class.distsim.crf.ser.gz -textFile $HOME_anu_tmp/tmp/$1_tmp/$1 1> $HOME_anu_tmp/tmp/$1_tmp/ner_org 2> /dev/null

perl run-ner.pl < $HOME_anu_tmp/tmp/$1_tmp/ner_org > $HOME_anu_tmp/tmp/$1_tmp/ner.txt
#sort -u $HOME_anu_tmp/tmp/$1_tmp/ner_tmp.txt > $HOME_anu_tmp/tmp/$1_tmp/ner.txt
