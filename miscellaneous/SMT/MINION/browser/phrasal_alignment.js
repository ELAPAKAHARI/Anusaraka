/*
Configuration file for English-Hinid language specifics
*/

var rows_visibility = [
1, // row1
0, // row2
0, // row3
0, // row4
0, // row5
0, // row6
0, // row7
0, // row8
0, // row9
0, // row10
1, // row11
1, // row12
1, // row13
1, // row14
1, // row15
1, // row16
0, // last row will be the suggestions row
]; // The array can be of different size than the number of rows at hand

var row_labels = [
"English (A)",
"Cautionary Signs (B)",
"Hindi padasutra (C)",
"Root (D)",
"Dictionary (E)",
"POS tag (F)",
"Chunker Marking (G)",
"Word Grouping (H)",
"Sense Disambiguation (I)",
"Preposition Movement (J)",
"Hindi Generation (K)",
"Phrasal meaning (E-H) (L)",
"Phrasal meaning (H-E) (M)",
"English and Hindi Parsers align  (N) ",
"Alignment with different sources (Anu, Dic, Wordnet)  (O) ",
"Manual meaning  (P) ",
"Suggestions (Q)"
];

var row_descriptions = [
"Original English text",
"Shows the cautionary sign for a word indicating a condition requiring special attention",
"Gives the Hindi gloss of English word",
"Shows root word(s) corresponding to the English word",
"Shows iit_bombay and shabdanjali dictionary meanings",
"Shows the best probable Part Of Speech in a given context",
"Shows the names of phrases (noun phrase, verb phrase, etc)",
"Gives the Hindi gloss of word as per PARSER(s)",
"Shows the Hindi meaning after disambiguating the word in a context",
"Shows the probable place to which preposition should be moved in Hindi output as per parser",
"Shows the Hindi word after calling the Hindi generator",
"Shows the manual word translation using  phrasal english to hindi training data",
"Shows the manual word translation using  phrasal hindi to english training data",
"Shows the manual aligned meaning with eng and hnd rel huristics",
"Shows the manual aligned meaning after applying huristics",
"Shows the manual aligned meaning after applying huristics",
"Shows the user suggestion"
];
