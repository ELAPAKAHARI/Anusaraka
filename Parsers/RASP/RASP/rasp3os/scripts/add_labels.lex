%{
int len=0,len1=0;
char str[100],str1[100],str2[100];
%}

%%
[(]VP[ ][(](VBZ|VBN)[ ][a-zA-Z0-9+]*[)][ ][(](RR|RL)[ ][a-zA-Z0-9+]*[)][ ][(]VVG[ ][a-zA-Z0-9+]*[)] {
                                         //He has been frequently coming.
                                         strcpy(str,yytext);
                                         len = strcspn(yytext," ");yytext=yytext+len+1;len1=len+1;
                                         len = strcspn(yytext," ");yytext=yytext+len+1;len1=len1+len+1;
                                         len = strcspn(yytext," ");yytext=yytext+len+1;len1=len1+len+1;
                                         strncpy(str1,str,len1);str1[len1]='\0'; strcpy(str,yytext);len1=0;
                                         len = strcspn(yytext," ");yytext=yytext+len+1;len1=len1+len+1;
                                         len = strcspn(yytext," ");yytext=yytext+len+1;len1=len1+len;
                                         strncpy(str2,str,len1);str2[len1]='\0';
                                         printf("%s(VP (ADVP %s) %s)",str1,str2,yytext); }

[^ADVP][ ][(](RR|RL)[ ]*[a-zA-Z0-9+]*[)] {//I went there with my mother.
                                         len = strcspn(yytext," ");strncpy(str1,yytext,len);str1[len]='\0';
                                         yytext=yytext+len+1; printf("%s (ADVP %s)",str1,yytext);}
(APP$|AT|AT1|JJ|NN1)[ ][a-zA-Z0-9+]*[)][ ][(](PPHS1|NP1|DD1|PPIS1|PPHS2|DB2|PPIS2|NN2|NN1)[ ][a-zA-Z0-9+]*[)] { 
                                          printf("%s",yytext);}
[^NP][ ][(](PPHS1|NP1|DD1|PPIS1|PPHS2|DB2|PPIS2|NN2|NN1|EX|PPY)[ ]*[a-zA-Z0-9+]*[)] { //We had wasted our journey.
                                         len = strcspn(yytext," ");strncpy(str1,yytext,len);str1[len]='\0';
                                         yytext=yytext+len+1; printf("%s (NP %s)",str1,yytext);}
[(]NP[ ][(](DT|AT1)[ ][a-zA-Z0-9+]*[)][ ][(](NN|NN1)[ ][a-zA-Z0-9+]*[))]  { //The boy saw [a child].
                                         printf("%s",yytext);
                                         }
[(](DT|AT1)[ ][a-zA-Z0-9+]*[)][ ][(](NN|NN1)[ ][a-zA-Z0-9+]*[)]  {// The blacksmith made [an assay] of iron ore.
                                         printf("(NP %s)",yytext);                                       
                                         }
[(VP][ ][(]VBZ[ ][a-zA-Z0-9+]*[)][ ][(]VVG[ ][a-zA-Z0-9+]*[)]    { //She is sleeping.
                                         strcpy(str,yytext);
                                         len = strcspn(yytext," ");yytext=yytext+len+1;len1=len+1;
                                         len = strcspn(yytext," ");yytext=yytext+len+1;len1=len1+len+1;
                                         len = strcspn(yytext," ");yytext=yytext+len+1;len1=len1+len+1;
                                         strncpy(str1,str,len1);str1[len1]='\0';
                                         printf("%s(VP %s)",str1,yytext); }
[(]VP[ ][(]RP[ ]                         { //I will give up smoking.
                                           len = strcspn(yytext," ");yytext=yytext+len+1;
                                           printf("(PRT %s",yytext); } 

[S][ ][(]DDQ[ ][a-zA-Z0-9+]*[)][ ][(][A-Z]*[ ]  { //What is your name?
                                         len = strcspn(yytext," ");yytext=yytext+len+1;
                                         len = strcspn(yytext," ");yytext=yytext+len+1;
                                         len = strcspn(yytext,")");
                                         strncpy(str,yytext,len);str[len]='\0';yytext=yytext+len+1;
                                         printf("SBARQ (WHNP (DDQ %s)) (SQ ",str);  }

[S][ ][(]VDD[ ][a-zA-Z0-9+]*[)]   { //Did you take your breakfast?
                                         len = strcspn(yytext,"(");yytext=yytext+len+1;
                                         len = strcspn(yytext," ");strncpy(str,yytext,len);str[len]='\0';yytext=yytext+len+1;
                                         printf("SQ (%s %s",str,yytext);
                                       } 
%%
