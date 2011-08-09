export scriptdir=`dirname $0`

#java  -mx500m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -sentences "newline" -outputFormat wordsAndTags,penn,typedDependencies -outputFormatOptions "basicDependencies, treeDependencies" $scriptdir/englishPCFG.ser.gz $*

#java  -mx500m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -sentences "newline" -outputFormat wordsAndTags,typedDependencies -outputFormatOptions "basicDependencies, CCPropagatedDependencies, treeDependencies" $scriptdir/englishPCFG.ser.gz $*

##presently running below one
#java  -mx900m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -retainTmpSubcategories -sentences "newline" -outputFormat wordsAndTags,typedDependencies -outputFormatOptions "basicDependencies, CCPropagatedDependencies, treeDependencies" $scriptdir/englishPCFG.ser.gz $*
java  -mx900m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -retainTmpSubcategories -sentences "newline" -outputFormat wordsAndTags,typedDependencies -printPCFGkBest 4 -outputFormatOptions "basicDependencies, CCPropagatedDependencies, treeDependencies" $scriptdir/englishPCFG.ser.gz $*



## below one is for constituents
#java  -mx500m -cp "$scriptdir/stanford-parser.jar:" edu.stanford.nlp.parser.lexparser.LexicalizedParser -sentences "newline" -outputFormat wordsAndTags,typedDependencies,penn -outputFormatOptions "lexicalize" $scriptdir/englishPCFG.ser.gz $*


