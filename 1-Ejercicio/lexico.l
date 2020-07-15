%{
    #include "sintactico.tab.h"
    //extern yylval
%}

numero [0-9]+

%%
\/          {return ENTRE;}
{numero}    {yylval.numero = atoi(yytext); return NUM;}
[\n]        {return EOL;}
" "         ;
%%

int yywrap(){
    return 0;
}