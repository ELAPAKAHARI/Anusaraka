export scriptdir=`dirname $0`

java  -mx500m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -sentences "newline" -outputFormat penn -outputFormatOptions "treeDependencies" $scriptdir/englishPCFG.ser.gz $*

