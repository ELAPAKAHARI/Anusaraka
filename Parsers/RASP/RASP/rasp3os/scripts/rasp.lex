%{
FILE *rel_fp,*cat_fp;
int flag=0,str_len=0,len=0,len1=0,len2=0;
char ch,str_tmp[100],str_tmp1[100],rel[100],lid[100],rid[100],subtype[100];
%}

%%
[\n][\n]                                         {flag=0;fprintf(cat_fp,";~~~~~~~~~~\n");}
gr-list:[ 1]+[\n]                                {flag=1;fprintf(rel_fp,";~~~~~~~~~~\n");}
[ 0-9]*[;][ (]*[-.0-9]*[)][\n]                 { }

[(][|][a-z]*[|][ ][|][a-z]*[|][ ][|][0-9A-Za-z+]*[:][0-9]*[_][A-Z0-9]*[ _|]*[0-9A-Za-z+]*[:][0-9]*[_][A-Z0-9$]*[|][ _)]*+[\n]  {
                                                   if(flag==1){
                                                   str_len=strlen(yytext);
                                                   len = strcspn(yytext,"|");yytext=yytext+len+1;
                                                   len2 = strcspn(yytext,"|");strncpy(rel,yytext,len2);rel[len2]='\0';
                                                   yytext=yytext+len2+1;
                                                   len = strcspn(yytext,"|");yytext=yytext+len+1;
                                                   len2 = strcspn(yytext,"|");strncpy(subtype,yytext,len2);subtype[len2]='\0';                                                  yytext=yytext+len2+1;
                                                   len = strcspn(yytext,":");yytext=yytext+len+1;
                                                   len2 = strcspn(yytext,"_");strncpy(lid,yytext,len2);lid[len2]='\0';
                                                   yytext=yytext+len2+1;
                                                   len = strcspn(yytext,":");yytext=yytext+len+1;
                                                   len2 = strcspn(yytext,"_");strncpy(rid,yytext,len2);rid[len2]='\0';
                                                   fprintf(rel_fp,"(rel_name-parserids\t%s\t%s\t%s)\n",rel,lid,rid);
                                                    }}

[(][|][a-z]*[ _|]*[0-9A-Za-z+]*[:][0-9]*[_][A-Z0-9]*[ _|]*[0-9A-Za-z+]*[:][0-9]*[_][A-Z0-9$]*[|][ _)]*+[\n]  {
                                                   if(flag==1){
                                                   str_len=strlen(yytext);
                                                   len = strcspn(yytext,"|");yytext=yytext+len+1;
                                                   len2 = strcspn(yytext,"|");strncpy(rel,yytext,len2);rel[len2]='\0';
                                                   yytext=yytext+len2+1;
                                                   len = strcspn(yytext,":");yytext=yytext+len+1;
                                                   len2 = strcspn(yytext,"_");strncpy(lid,yytext,len2);lid[len2]='\0';
                                                   yytext=yytext+len2+1;
                                                   len = strcspn(yytext,":");yytext=yytext+len+1;
                                                   len2 = strcspn(yytext,"_");strncpy(rid,yytext,len2);rid[len2]='\0';
                                                   fprintf(rel_fp,"(rel_name-parserids\t%s\t%s\t%s)\n",rel,lid,rid);
                                                    }}
[(]                                              { }
[|][A-Za-z+,\.\?!]*[:][0-9]*[_][A-Z0-9$,\.\?!]*[|]  { if(flag==0){
                                                     str_len=strlen(yytext);
                                                     len = strcspn(yytext,":");
                                                     yytext=yytext+len+1;
                                                     len1 = strcspn(yytext,"_");
                                                     strncpy(str_tmp,yytext,len1);   
                                                     str_tmp[len1]='\0';                                                 
                                                     yytext=yytext+len1+1;
                                                     len2 = strcspn(yytext,"|");
                                                     strncpy(str_tmp1,yytext,len2);                              
                                                     str_tmp1[len2]='\0';        
                                                     fprintf(cat_fp,"(id-cat\t%s\t%s)\n",str_tmp,str_tmp1);
                                                   }}

[)]|[ ]|[\n]                                          { }
%%

main(int argc, char* argv[])
{
rel_fp=fopen(argv[1],"w");
cat_fp=fopen(argv[2],"w");
yylex();
fclose(rel_fp);
fclose(cat_fp);
}

