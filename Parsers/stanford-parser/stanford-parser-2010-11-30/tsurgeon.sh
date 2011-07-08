export scriptdir=`dirname $0`


java -mx900m -cp "$scriptdir/stanford-tregex.jar:" edu.stanford.nlp.trees.tregex.tsurgeon.Tsurgeon "$@"
