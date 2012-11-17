/********************
Mapping punctuation with a standard notation.
Removed sed and handled it in this flex programme. 
*********************/

%{
char str[1000], str1[1000], *s1, *s2;
int len, len1;
%}

%%

\(,[ ],\)		{	printf("(P_COM PUNCT-Comma)");		}

\([.][ ][.]\)		{	printf("(P_DOT PUNCT-Dot)");		}

\(\.[ ]\?\)		{	printf("(P_QES PUNCT-QuestionMark)");	}

\(\?[ ]\?\)		{	printf("(P_QES PUNCT-QuestionMark)");	}

\(``[ ]``\)		{	printf("(P_DQT PUNCT-DoubleQuote)");	}

\(''[ ]''\)		{	printf("(P_DQT PUNCT-DoubleQuote)");	}

\(:[ ];\)		{	printf("(P_SEM PUNCT-Semicolon)");	}

\(,[ ];\)		{	printf("(P_SEM PUNCT-Semicolon)");	}

\(:[ ]:\)		{	printf("(P_CLN PUNCT-Colon)");		}

\(:[ ]-\)		{	printf("(P_DSH PUNCT-Hyphen)");		}

\(:[ ][.][.][.]\)       {       printf("(P_TDOT PUNCT-DotDotDot)");	}

\(''[ ]'\)		{	printf("(P_SQT PUNCT-SingleQuote)");	}

\(``[ ]`\)		{	printf("(P_SQT PUNCT-SingleQuote)");	}

\(``[ ]'\)		{	printf("(P_SQT PUNCT-SingleQuote)");	}

\(\-LRB\-[ ]\-LRB\-\)	{	printf("(P_LB PUNCT-OpenParen)");	}

\(\-RRB\-[ ]\-RRB\-\)	{	printf("(P_RB PUNCT-ClosedParen)");	}

\(\.[ ]!\)		{	printf("(P_EXM PUNCT-Exclamation)");	}

\(:[ ]\'\)		{	printf("(P_SQT PUNCT-SingleQuote)"); /* Added this for Berkeley Parser purpose. Ex: For quenchers, try the Sharjah shake delightful concoction of bananas, milk, sugar and cardamom' it is the king of all fruit shakes.*/	} 

\(\$[ ]Rs\)		{	printf("(P_DOL Rs)");  /* Added this for Berkeley Parser purpose. Ex: The uru will cost Rs 500. */			}

\([A-Z$]+[ ][0-9a-zA-Z]+[/][0-9a-zA-Z]+\)	{	len=strcspn(yytext, " ");
					strncpy(str, yytext, len); str[len]='\0';

					s1=strchr(yytext, ' ')+1;
					len1=strcspn(s1, "/");
					strncpy(str1, s1, len1); str1[len1]='\0';

					s2=strchr(s1, '/')+1;
					printf("%s %s) %s SYMBOL-SLASH) %s %s", str, str1, str, str, s2);
			/* Ex: To describe motion in two/three dimensions, we need a set of two/three axis. */
				}
%%
