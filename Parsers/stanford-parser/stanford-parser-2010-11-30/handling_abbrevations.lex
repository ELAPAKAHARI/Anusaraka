/*Added by Roja (13-08-12)		*/
/*Handling Abbrevations which are not handled by Stanford Parser. */
/*Ex: Fig. , Eq. , viz. , Ch. , abbrv.	*/
/*I/p:: (NNP Fig) (. .) 		*/
/*O/p:: (NNP Fig.)			*/

%{
#include <string.h>
int len;
char str[1000];
%}

%%

([Ff]igs?|[Ee]qs?|[Vv]izs?|[Cc]h|abbrv|USA)\)[ ]\([.][ ][.]\)	{	len=strcspn(yytext, ")");
									strncpy(str, yytext, len);
									str[len]='\0';
									
									printf("%s.)", str);
								 }

%%
