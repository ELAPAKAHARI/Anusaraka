%{
char str[1000],str1[1000],str2[1000],*s1,*s2;
int len,len1=0,len2=0,count=0,sent_len=0,len3=0,sent_len1=0;
FILE *fp,*fp1;
%}

%%

^Parsing[ ]\[sent.[ ][0-9]*[ ]len.[ ][0-9]*\]:[ \[\]a-zA-Z0-9,!;:\"-_`']*\n  {
                                                                         len=strcspn(yytext,":");
                                                                         yytext=yytext+len+3;
                                                                         count=1;
                                                                         len3=strcspn(yytext,"\n");
                                                                         strncpy(str1,yytext,len3);
                                                                         str1[len3++]='\0';
                                                                         yytext=str1;
                                                                         sent_len=strlen(str1);
                                                                         while(len1<sent_len)
                                                                         { 
                                                                          len2=strcspn(yytext," ]");
                                                                          strncpy(str,yytext,len2);
                                                                          str[len2++]='\0';
                                                                          sent_len1=strlen(str);
                                                                          if(*(str+(sent_len1-1))==',')
                                                                          {
                                                                          sent_len1=sent_len1-1;
                                                                          strncpy(str2,yytext,sent_len1);
                                                                          str2[sent_len1++]='\0';
                                                                          if((strcmp(str2,"?")==0)|(strcmp(str2,";")==0)|(strcmp(str2,"\"")==0)|(strcmp(str2,")")==0)|(strcmp(str2,"(")==0)|(strcmp(str2,".")==0)|(strcmp(str2,"[")==0)|(strcmp(str2,"]")==0)|(strcmp(str2,"!")==0))
                                                                          {fprintf(fp,"(parserid-word P%d \"%s\")\n",count,str2);
                                                                          fprintf(fp1,"(parser_numeric_id-word %d \"%s\")\n",count,str2);}
                                                                          else
                                                                          {fprintf(fp,"(parserid-word P%d %s)\n",count,str2);
                                                                          fprintf(fp1,"(parser_numeric_id-word %d %s)\n",count,str2);}
                                                                          }
                                                                          else
                                                                          {
                                                                         if((strcmp(str,"?")==0)|(strcmp(str,";")==0)|(strcmp(str,"\"")==0)|(strcmp(str,")")==0)|(strcmp(str,"(")==0)|(strcmp(str,".")==0)|(strcmp(str,"[")==0)|(strcmp(str,"]")==0)|(strcmp(str,"!")==0))
                                                                          {fprintf(fp,"(parserid-word P%d \"%s\")\n",count,str);
                                                                          fprintf(fp1,"(parser_numeric_id-word %d \"%s\")\n",count,str);}
                                                                          else
                                                                          { fprintf(fp,"(parserid-word P%d %s)\n",count,str);
                                                                           fprintf(fp1,"(parser_numeric_id-word %d %s)\n",count,str);}}
                                                                          yytext=yytext+len2;
                                                                          len1=len1+len2;                                                                                                              count=count+1;
                                                                          }
                                                                          
                                                                         count=0;len=0;len1=0;len2=0,sent_len=0,sent_len1=0;
                                                                         fprintf(fp,";~~~~~~~~~~\n");
                                                                         fprintf(fp1,";~~~~~~~~~~\n");
                                                                         }
[ ]                                                                     { }
[\n]                                                                    { }
%%


main(int argc,char *argv[])
{
fp=fopen(argv[1],"w");
fp1=fopen(argv[2],"w");
yylex();
fclose(fp);
fclose(fp1);
}
