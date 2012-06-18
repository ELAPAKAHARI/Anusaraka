/********************
Mapping punctuation with a standard notation.
Removed sed and handled it in this flex programme. 
*********************/
%{
char *s, str[1000];
int len;
%}

%%

\(,[ ],\)		{	printf("(P_COM PUNCT-Comma)");	}

\([.][ ][.]\)		{	printf("(P_DOT PUNCT-Dot)");	}

\(\.[ ]\?\)		{	printf("(P_DQ PUNCT-QuestionMark)");	}

\(\?[ ]\?\)		{	printf("(P_QES PUNCT-QuestionMark)");	}

\(``[ ]``\)		{	printf("(P_DQT PUNCT-DoubleQuote)");	}

\(''[ ]''\)		{	printf("(P_DQT PUNCT-DoubleQuote)");	}

\(:[ ];\)		{	printf("(P_SEM PUNCT-Semicolon)");	}

\(:[ ]:\)		{	printf("(P_CLN PUNCT-Colon)");	}

\(:[ ]-\)		{	printf("(P_DSH PUNCT-Hyphen)");	}

\(''[ ]'\)		{	printf("(P_SQT PUNCT-SingleQuote)");	}

\(``[ ]`\)		{	printf("(P_SQT PUNCT-SingleQuote)");	}

\(``[ ]'\)		{	printf("(P_SQT PUNCT-SingleQuote)");	}

\(\-LRB\-[ ]\-LRB\-\)	{	printf("(P_LB PUNCT-OpenParen)");	}

\(\-RRB\-[ ]\-RRB\-\)	{	printf("(P_RB PUNCT-ClosedParen)");	}

\(\.[ ]!\)		{	printf("(P_EXM PUNCT-Exclamation)");	}

\($[ ]$\)		{	printf("(S_DOL SYM-Dollar)");	}

\([A-Z]*[ ]=\)		{	s=strchr(yytext, '(')+1;
				len=strcspn(s, " ");
				strncpy(str, s, len); str[len]='\0'; 
				printf("(%s SYM-EqualTo)", str);	}

\([A-Z]*[ ]\+\)		{	s=strchr(yytext, '(')+1;
                                len=strcspn(s, " ");
                                strncpy(str, s, len); str[len]='\0';
				printf("(%s SYM-PLUS)", str);		}

\([A-Z]*[ ]%\)		{	s=strchr(yytext, '(')+1;
                                len=strcspn(s, " ");
                                strncpy(str, s, len); str[len]='\0';
				printf("(%s SYM-PERC)", str);		}

%%
