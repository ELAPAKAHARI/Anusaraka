%{
#include<string.h>
FILE *fp;
int len=0,comma_cnt=0,len1=0;
char id[100],node[20],root[100],cat[20],gen[20],num[20],per[20],cas[20],tam[50],new_tam[50],*t,new_text[100];
%}
%%
[0-9]*[\t]\(\([\t][A-Z]*[\t]<fs[ ]af='[a-zA-Z0-9_,+]*'[ ]head=\"[a-zA-Z,._]*\"[ ]vpos=\"[a-z0-9_]*\">  {
					comma_cnt = 0;
					len = strcspn(yytext,"\t");
                                        strncpy(id,yytext,len);
                                        id[len]='\0';
                                        yytext=yytext+len+1;
					len = strcspn(yytext,"\t");yytext=yytext+len+1;
					len = strcspn(yytext,"\t");
					strncpy(node,yytext,len);
					node[len]='\0';
					yytext=yytext+len+1;
					len = strcspn(yytext,"'");yytext=yytext+len+1;
		while ((len = strcspn(yytext,","))>=0 && comma_cnt <=7) {
          	   comma_cnt = comma_cnt +1 ;
		if (comma_cnt == 1) { strncpy(root,yytext,len); root[len]='\0';if(strcmp(root,"\0")==0) strcpy(root,"-");}
        	if (comma_cnt == 2) { strncpy(cat,yytext,len);  cat[len]='\0'; if(strcmp(cat,"\0")==0) strcpy(cat,"-");}
		if (comma_cnt == 3) { strncpy(gen,yytext,len);  gen[len]='\0'; if(strcmp(gen,"\0")==0) strcpy(gen,"-");}
                if (comma_cnt == 4) { strncpy(num,yytext,len);  num[len]='\0'; if(strcmp(num,"\0")==0) strcpy(num,"-");}
                if (comma_cnt == 5) { strncpy(per,yytext,len);  per[len]='\0'; if(strcmp(per,"\0")==0) strcpy(per,"-");}
	        if (comma_cnt == 6) { strncpy(cas,yytext,len);  cas[len]='\0'; if(strcmp(cas,"\0")==0) strcpy(cas,"-");}
	        if (comma_cnt == 7) { strncpy(tam,yytext,len);  tam[len]='\0'; t=tam; 
                                    while ((len1 = strcspn(t,"+"))>0 && len1<strlen(t)) { 
                                    strncat(new_tam,t,len1);
                                    t=t+len1+1; 
					}
                                    strcat(new_tam,t);    
 				   if(strcmp(new_tam,"\0")==0) strcpy(new_tam,"-");}
                   yytext=yytext+len+1;
		}
                                        
		fprintf(fp,"(id-node-root-cat-gen-num-per-case-tam %s %s %s %s %s %s %s %s %s)\n",id,node,root,cat,gen,num,per,cas,new_tam);
		*id='\0';*root='\0';*node='\0';*cat='\0';*gen='\0';*num='\0';*per='\0';*cas='\0';*tam='\0';*new_tam='\0';*t='\0';
		}
[0-9]*[\t]\(\([\t][A-Z]*[\t]<fs[ ]af='[a-zA-Z0-9_,+]*'[ ]head=\"[A-Za-z,._]*\"> { comma_cnt = 0;
                                        len = strcspn(yytext,"\t");
                                        strncpy(id,yytext,len);
                                        id[len]='\0';
                                        yytext=yytext+len+1;
                                        len = strcspn(yytext,"\t");yytext=yytext+len+1;
                                        len = strcspn(yytext,"\t");
                                        strncpy(node,yytext,len);
                                        node[len]='\0';
                                        yytext=yytext+len+1;
                                        len = strcspn(yytext,"'");yytext=yytext+len+1;
                while ((len = strcspn(yytext,","))>=0 && comma_cnt <=7) {
                   comma_cnt = comma_cnt +1 ;
                if (comma_cnt == 1) { strncpy(root,yytext,len); root[len]='\0';if(strcmp(root,"\0")==0) strcpy(root,"-");}
                if (comma_cnt == 2) { strncpy(cat,yytext,len);  cat[len]='\0'; if(strcmp(cat,"\0")==0) strcpy(cat,"-");}
                if (comma_cnt == 3) { strncpy(gen,yytext,len);  gen[len]='\0'; if(strcmp(gen,"\0")==0) strcpy(gen,"-");}
                if (comma_cnt == 4) { strncpy(num,yytext,len);  num[len]='\0'; if(strcmp(num,"\0")==0) strcpy(num,"-");}
                if (comma_cnt == 5) { strncpy(per,yytext,len);  per[len]='\0'; if(strcmp(per,"\0")==0) strcpy(per,"-");}
                if (comma_cnt == 6) { strncpy(cas,yytext,len);  cas[len]='\0'; if(strcmp(cas,"\0")==0) strcpy(cas,"-");}
                if (comma_cnt == 7) { strncpy(tam,yytext,len);  tam[len]='\0'; t=tam;
                                    while ((len1 = strcspn(t,"+"))>0 && len1<strlen(t)) {
                                    strncat(new_tam,t,len1);
                                    t=t+len1+1;}
                                    strcat(new_tam,t);
                                   if(strcmp(new_tam,"\0")==0) strcpy(new_tam,"-");}
                   yytext=yytext+len+1;
                }

                fprintf(fp,"(id-node-root-cat-gen-num-per-case-tam %s %s %s %s %s %s %s %s %s)\n",id,node,root,cat,gen,num,per,cas,new_tam);
                *id='\0';*root='\0';*node='\0';*cat='\0';*gen='\0';*num='\0';*per='\0';*cas='\0';*tam='\0';*new_tam='\0';*t='\0';
 }
[0-9]*[\t]\(\([\t][A-Z]*[\t]<fs[ ]af='[a-zA-Z0-9_,+]*'[ ]head=\"[A-Za-z0-9_,.]*\"[ ]poslcat=\"[A-Z]*\"[ ]vpos=\"[a-z0-9_A-Z]*\"> { 
                                       comma_cnt = 0;
                                        len = strcspn(yytext,"\t");
                                        strncpy(id,yytext,len);
                                        id[len]='\0';
                                        yytext=yytext+len+1;
                                        len = strcspn(yytext,"\t");yytext=yytext+len+1;
                                        len = strcspn(yytext,"\t");
                                        strncpy(node,yytext,len);
                                        node[len]='\0';
                                        yytext=yytext+len+1;
                                        len = strcspn(yytext,"'");yytext=yytext+len+1;
                while ((len = strcspn(yytext,","))>=0 && comma_cnt <=7) {
                   comma_cnt = comma_cnt +1 ;
                if (comma_cnt == 1) { strncpy(root,yytext,len); root[len]='\0';if(strcmp(root,"\0")==0) strcpy(root,"-");}
                if (comma_cnt == 2) { strncpy(cat,yytext,len);  cat[len]='\0'; if(strcmp(cat,"\0")==0) strcpy(cat,"-");}
                if (comma_cnt == 3) { strncpy(gen,yytext,len);  gen[len]='\0'; if(strcmp(gen,"\0")==0) strcpy(gen,"-");}
                if (comma_cnt == 4) { strncpy(num,yytext,len);  num[len]='\0'; if(strcmp(num,"\0")==0) strcpy(num,"-");}
                if (comma_cnt == 5) { strncpy(per,yytext,len);  per[len]='\0'; if(strcmp(per,"\0")==0) strcpy(per,"-");}
                if (comma_cnt == 6) { strncpy(cas,yytext,len);  cas[len]='\0'; if(strcmp(cas,"\0")==0) strcpy(cas,"-");}
                if (comma_cnt == 7) { strncpy(tam,yytext,len);  tam[len]='\0'; t=tam;
                                    while ((len1 = strcspn(t,"+"))>0 && len1<strlen(t)) {
                                    strncat(new_tam,t,len1);
                                    t=t+len1+1;}
                                    strcat(new_tam,t);
                                   if(strcmp(new_tam,"\0")==0) strcpy(new_tam,"-");}
                   yytext=yytext+len+1;
                }

                fprintf(fp,"(id-node-root-cat-gen-num-per-case-tam %s %s %s %s %s %s %s %s %s)\n",id,node,root,cat,gen,num,per,cas,new_tam);
 *id='\0';*root='\0';*node='\0';*cat='\0';*gen='\0';*num='\0';*per='\0';*cas='\0';*tam='\0';*new_tam='\0';*t='\0';
}

[0-9]*[\t]\(\([\t][A-Z]*[\t]<fs[ ]af='[a-zA-Z0-9_,+]*'[ ]poslcat=\"[A-Z]*\"[ ]head=\"[a-zA-Z_,.]*\"> {
  comma_cnt = 0;
                                        len = strcspn(yytext,"\t");
                                        strncpy(id,yytext,len);
                                        id[len]='\0';
                                        yytext=yytext+len+1;
                                        len = strcspn(yytext,"\t");yytext=yytext+len+1;
                                        len = strcspn(yytext,"\t");
                                        strncpy(node,yytext,len);
                                        node[len]='\0';
                                        yytext=yytext+len+1;
                                        len = strcspn(yytext,"'");yytext=yytext+len+1;
                while ((len = strcspn(yytext,","))>=0 && comma_cnt <=7) {
                   comma_cnt = comma_cnt +1 ;
                if (comma_cnt == 1) { strncpy(root,yytext,len); root[len]='\0';if(strcmp(root,"\0")==0) strcpy(root,"-");}
                if (comma_cnt == 2) { strncpy(cat,yytext,len);  cat[len]='\0'; if(strcmp(cat,"\0")==0) strcpy(cat,"-");}
                if (comma_cnt == 3) { strncpy(gen,yytext,len);  gen[len]='\0'; if(strcmp(gen,"\0")==0) strcpy(gen,"-");}
                if (comma_cnt == 4) { strncpy(num,yytext,len);  num[len]='\0'; if(strcmp(num,"\0")==0) strcpy(num,"-");}
                if (comma_cnt == 5) { strncpy(per,yytext,len);  per[len]='\0'; if(strcmp(per,"\0")==0) strcpy(per,"-");}
                if (comma_cnt == 6) { strncpy(cas,yytext,len);  cas[len]='\0'; if(strcmp(cas,"\0")==0) strcpy(cas,"-");}
                if (comma_cnt == 7) { strncpy(tam,yytext,len);  tam[len]='\0'; t=tam;
                                    while ((len1 = strcspn(t,"+"))>0 && len1<strlen(t)) {
                                    strncat(new_tam,t,len1);
                                    t=t+len1+1;}
                                    strcat(new_tam,t);
                                   if(strcmp(new_tam,"\0")==0) strcpy(new_tam,"-");}
                   yytext=yytext+len+1;
                }

                fprintf(fp,"(id-node-root-cat-gen-num-per-case-tam %s %s %s %s %s %s %s %s %s)\n",id,node,root,cat,gen,num,per,cas,new_tam);
 *id='\0';*root='\0';*node='\0';*cat='\0';*gen='\0';*num='\0';*per='\0';*cas='\0';*tam='\0';*new_tam='\0';*t='\0';
}


%%
main(int argc, char* argv[])
{
fp= fopen(argv[1],"w");
yylex();
fclose(fp);
}
