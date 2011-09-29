export scriptdir=`dirname $0`

#java  -mx900m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -sentences "newline" -outputFormat penn -outputFormatOptions "treeDependencies" $scriptdir/englishPCFG.ser.gz $*

java  -mx900m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -sentences "newline" -outputFormat oneline -outputFormatOptions "treeDependencies" $scriptdir/englishPCFG.ser.gz $*

