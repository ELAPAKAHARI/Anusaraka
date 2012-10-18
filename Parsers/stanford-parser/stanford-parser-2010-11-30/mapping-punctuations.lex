/********************
Mapping punctuation with a standard notation.
Removed sed and handled it in this flex programme. 
*********************/

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



%%
