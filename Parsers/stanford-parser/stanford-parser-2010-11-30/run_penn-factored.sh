## Created this file separately on Chaitanya Sir suggestion. 
## Passing grammar file as an argument consumes more time while compared to passing in the file itself.(Added by Roja 5-1-12)

export scriptdir=`dirname $0`


java  -mx900m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -sentences "newline" -outputFormat oneline -outputFormatOptions "treeDependencies" -tokenizerOptions americanize=false $scriptdir/englishFactored.ser.gz $*
