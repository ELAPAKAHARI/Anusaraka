export scriptdir=`dirname $0`

java -mx800m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.trees.TreePrint -options "lexicalize" $1
