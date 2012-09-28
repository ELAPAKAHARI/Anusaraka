/********************
Mapping punctuation with a standard notation.
Removed sed and handled it in this flex programme. 
*********************/
%{
char *s, *s1, str[1000];
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

\(:[ ][.][.][.]\)       {       printf("(P_CLN PUNCT-DotDotDot)"); }

\(''[ ]'\)		{	printf("(P_SQT PUNCT-SingleQuote)");	}

\(``[ ]`\)		{	printf("(P_SQT PUNCT-SingleQuote)");	}

\(``[ ]'\)		{	printf("(P_SQT PUNCT-SingleQuote)");	}

\(\-LRB\-[ ]\-LRB\-\)	{	printf("(P_LB PUNCT-OpenParen)");	}

\(\-RRB\-[ ]\-RRB\-\)	{	printf("(P_RB PUNCT-ClosedParen)");	}

\(\.[ ]!\)		{	printf("(P_EXM PUNCT-Exclamation)");	}

\($[ ]$\)		{	printf("(S_DOL SYM-Dollar)");	}

\(:[ ][-][-]\)		{	printf("(P_DDSH PUNCT-HyphenHyphen)");	}

\(#[ ]#\)		{	printf("(S_SHARP SYM-Sharp)");	}

\([A-Z]*[ ]=[A-Za-z0-9.]*\)	{	s=strchr(yytext, '(')+1;
					len=strcspn(s, " ");
					strncpy(str, s, len); str[len]='\0'; 
					s1=strchr(s, '=')+1;
					printf("(%s SYM-EqualTo%s", str, s1);	}

\([A-Z]*[ ]\+[A-Za-z0-9.]*\)	{	s=strchr(yytext, '(')+1;
               		                len=strcspn(s, " ");
	                                strncpy(str, s, len); str[len]='\0';
					s1=strchr(s, '+')+1;
					printf("(%s SYM-Plus%s", str, s1);	}

\([A-Z]*[ ]%[A-Za-z0-9.]*\)	{	s=strchr(yytext, '(')+1;
        		                len=strcspn(s, " ");
                        	        strncpy(str, s, len); str[len]='\0';
					s1=strchr(s, '%')+1;
					printf("(%s SYM-Percent%s", str, s1); /*	}

\([A-Z]*[ ]β[A-Za-z0-9.]*\)     {       s=strchr(yytext, '(')+1;
                                	len=strcspn(s, " ");
	                                strncpy(str, s, len); str[len]='\0';
					s1=strchr(s, 'β')+1;
        	                        printf("(%s SYM-Beta%s", str, s1);	*/	}

%%
