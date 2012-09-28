/*Added by Roja (13-08-12)		*/
/*Handling Abbrevations which are not handled by Stanford Parser. */
/*Ex: Fig. , Eq. , viz. , Ch. , abbrv.	*/
/*I/p:: (NNP Fig) (. .) 		*/
/*O/p:: (NNP Fig.)			*/

%{
#include <string.h>
int len;
char str[1000], *s1, *s2;
%}

%%

([Ff]igs?|[Ee]qs?|[Vv]izs?|[Cc]h|abbrv|USA|distt)\)[ ]\([.][ ][.]\)	{	len=strcspn(yytext, ")");
										strncpy(str, yytext, len);
										str[len]='\0';
										
										printf("%s.)", str);
										/*Ex: (NNP Fig) (. .) */
									}

[0-9]*\)\)[ ]\([A-Z]*[ ]nonascii[0-9]*\) {	len=strcspn(yytext, ")");
						strncpy(str, yytext, len);
						str[len]='\0';

						s1=strchr(yytext, ' ')+1;
						s2=strchr(s1, ' ')+1;
						printf("%s%s)", str, s2);
						/*Ex: (CD 30)) (JJ nonascii2194176)  */
					}
%%
