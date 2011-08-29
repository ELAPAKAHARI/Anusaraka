%{
#include <stdio.h>
#include<string.h>
char str[1000],str1[1000];
int count=1,len=0,count1=0,count2=0;
FILE *fp,*fp1,*fp2;

%}


%%

[)]\n                                {count=1;fprintf(fp,";~~~~~~~~~~\n");
                                              fprintf(fp1,";~~~~~~~~~~\n");
                                              fprintf(fp2,";~~~~~~~~~~\n");
                                      }
[(][A-Z$-]*[ ][a-zA-Z0-9.',-]*[)]         {
                                        count1=count; count2=count;
                                        len=strcspn(yytext," ");
                                        strncpy(str,yytext+1,len);
                                        str[len-1]='\0';
                                        strcpy(str1,str);
                                        fprintf(fp1,"(id-sd_cat	P%d	%s)\n",count++,str);
                                        yytext=yytext+len+1;
                                        len=strcspn(yytext,")");
                                        strncpy(str,yytext,len);
                                        str[len]='\0';
                                        fprintf(fp,"(parser_numeric_id-word      %d      %s)\n",count1++,str);
                                        fprintf(fp2,"(parserid-word      P%d      %s)\n",count2++,str);
                                        }


[(][.,?!"':`]*[ ][.,?!;"':`]*[)]        { count1=count; count2=count; 
                                      len=strcspn(yytext," ");
                                      strncpy(str,yytext,len);
                                      yytext=yytext+len+1;
                                      len=strcspn(yytext,")");
                                      strncpy(str,yytext,len);
                                      str[len]='\0';
                                      if(strcmp(str,"?")==0)  strcpy(str,"question_mark");
                                      if(strcmp(str,";")==0)  strcpy(str,"semicolon"); 
                                      if(strcmp(str,"\"")==0) strcpy(str,"\"\"\"");
                                      fprintf(fp1,"(id-sd_cat P%d    %s)\n",count++,str);
                                      fprintf(fp,"(parser_numeric_id-word      %d      %s)\n",count1++,str);
                                      fprintf(fp2,"(parserid-word      P%d      %s)\n",count2++,str);}

%%



main(int argc, char* argv[])
{
fp=fopen(argv[1],"a");
fp1=fopen(argv[2],"a");
fp2=fopen(argv[3],"a");
yylex();
fclose(fp);
}
