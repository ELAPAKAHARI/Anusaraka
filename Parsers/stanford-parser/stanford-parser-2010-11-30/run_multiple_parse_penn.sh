export scriptdir=`dirname $0`

java  -mx900m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -sentences "newline" -outputFormat oneline -outputFormatOptions "treeDependencies" -printPCFGkBest 25 -tokenizerOptions "americanize=false, escapeForwardSlashAsterisk=false" $scriptdir/englishPCFG.ser.gz $*

