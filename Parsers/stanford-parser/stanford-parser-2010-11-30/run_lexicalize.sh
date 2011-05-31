export scriptdir=`dirname $0`

java  -mx500m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -sentences "newline" -outputFormat penn -outputFormatOptions "treeDependencies" -outputFormatOptions lexicalize $scriptdir/englishPCFG.ser.gz $*

#java  -mx500m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -sentences "newline" -outputFormat wordsAndTags,typedDependencies,penn -outputFormatOptions "lexicalize" $scriptdir/englishPCFG.ser.gz $*


