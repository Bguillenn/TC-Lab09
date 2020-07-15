%{
    #include "sintactico.tab.h"
%}
real    [0-9]+\.[0-9]+
id      [a-z]+
%%
float   {return FLOAT;}
{id}      {yylval.nombre = yytext; return ID;}
{real}    {yylval.valor = atof(yytext); return REAL;}
"="     {return IGUAL;}
";"     {return PYC;}
[\n]    {return EOL;}
" "     ;
%%

int yywrap(){
    return 0;
}