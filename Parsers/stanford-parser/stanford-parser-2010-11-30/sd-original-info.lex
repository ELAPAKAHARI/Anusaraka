%{
char *s1;
%}

%%

[\n][A-Za-z0-9'`.]*[/][A-Z0-9.]*     {      s1=strchr(yytext, '\n')+1;
                                            printf("\n;~~~~~~~~~~\n%s",s1);  } 


[A-Za-z_]*\([A-Za-z0-9'-.]*[-][0-9]*[,][ ][A-Za-z0-9'-.]*[-][0-9]*\)\n   { printf("%s", yytext); }



^[\n]                                {   printf("\n");  }

%%
