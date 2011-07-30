%{
int len=0;
char str[100],str1[100];
%}

%%
[(]VBZ[ ]be[+]s[)]            	{printf("(VHZ is)");}
[(]VBR[ ]be[+][)]             	{printf("(VBR are)");}
[(]VBM[ ]be[+][)]             	{printf("(VBM am)");}
[(]VBDZ[ ]be[+]ed[)]          	{printf("(VBDZ was)");}
[(]PPHO2[ ]they[+][)]               {printf("(PPHO2 them)");}
[(]PPHO1[ ]he[+][)]                 {printf("(PPHO1 him)");}
[(]PPIO1[ ]I[+][)]                  {printf("(PPIO1 me)");}
[(][$][ ]'s[+][)]                   {printf("($ 's)");}
[(]XX[ ]not[+][)]                   {printf("(XX not)");}
[(]V[VDHZ]*[ ][a-zA-Z]*[+]s[)] 	{len = strcspn(yytext," ");strncpy(str1,yytext,len);str1[len]='\0';
                             	yytext=yytext+len+1;len = strcspn(yytext,"+");strncpy(str,yytext,len);
                             	str[len]='\0';printf("%s ^%s<vblex><pri><p3><sg>$)",str1,str);}   
[(]VBN[ ][a-zA-Z]*[+]en[)]    	{len = strcspn(yytext," ");yytext=yytext+len+1;len = strcspn(yytext,"+");
                             	strncpy(str,yytext,len);str[len]='\0';printf("(VBN ^%s<vbser><pp>$)",str);}
[(]VVG[ ][a-zA-Z]*[+]ing[)]   	{len = strcspn(yytext," ");yytext=yytext+len+1;len = strcspn(yytext,"+");
                             	strncpy(str,yytext,len);str[len]='\0';printf("(VVG ^%s<vblex><ger>$)",str);}
[(]V[BZVDHN]*[ ][a-zA-Z]*[+]ed[)] 	{len = strcspn(yytext," ");strncpy(str1,yytext,len);str1[len]='\0';
                             	yytext=yytext+len+1;len = strcspn(yytext,"+");strncpy(str,yytext,len);
                             	str[len]='\0';printf("%s ^%s<vblex><past>$)",str1,str);}
[(]V[VN]*[ ][a-zA-Z]*[+]en[)] 	{len = strcspn(yytext," ");strncpy(str1,yytext,len);str1[len]='\0';
                             	yytext=yytext+len+1;len = strcspn(yytext,"+");strncpy(str,yytext,len);
                             	str[len]='\0';printf("%s ^%s<vblex><pp>$)",str1,str);}
[(]NN2[ ][a-zA-Z]*[+]s[)]  	{len = strcspn(yytext," ");strncpy(str1,yytext,len);str1[len]='\0';
                          	yytext=yytext+len+1;len = strcspn(yytext,"+");strncpy(str,yytext,len);
                          	str[len]='\0';printf("%s ^%s<n><pl>$)",str1,str);}
%%

/*main(int argc, char* argv[])
{
fp=fopen(argv[1],"w");
yylex();
fclose(fp);
}*/

