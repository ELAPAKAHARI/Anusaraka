%{
char str[1000],str1[1000],str2[1000],*s1,*s2;
int len,len1=0,len2=0,count=0,sent_len=0,len3=0,sent_len1=0;
FILE *fp,*fp1;
%}

%%

^\n                            {printf(";~~~~~~~~~~\n");}

%%


main(int argc,char *argv[])
{
//fp=fopen(argv[1],"w");
//fp1=fopen(argv[2],"w");
yylex();
//fclose(fp);
//fclose(fp1);
}
