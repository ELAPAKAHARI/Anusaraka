flex  rasp_constituency_parse.l
bison --yacc -d  rasp_constituency_parse.y
gcc -g lex.yy.c y.tab.c -o  rasp_constituency_parse
