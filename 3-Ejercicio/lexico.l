%{
    #include "sintactico.tab.h"
    /*
    externt yylval
    */
%}
numero [0-9]+
id [a-zA-Z]+
%%
{numero} {yylval.valor= atoi(yytext);return ENTERO;}
{id} {yylval.name = yytext; return ID;}
"\n" {return FINLINEA;}
"(" {return PAR_IZQ;}
")" {return PAR_DER;}
"+" {return SUMA;}
"-" {return RESTA;}
"*" {return MULTIPLICACION;}
"/" {return DIVISION;}
"=" {return IGUAL;}
" " ;
%%
int yywrap(){
 return 0;
}
