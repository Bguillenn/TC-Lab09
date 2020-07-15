%{
    #include <stdio.h>
    #include <string.h>
    #define YYDEBUG 1
    extern int yylex(void);
    extern char *yytext;
    void yyerror (char*);
%}
%union{
    struct var{
        char*tipo;
        int valor;
    } atributos2;
    struct var2{
        char*tipo;
        int valor;
        char*nombre;
    } variable;
    int valor;
    char * name;
}
%token ID
%token FINLINEA
%token <valor> ENTERO
%token PAR_DER PAR_IZQ
%token IGUAL
%left SUMA RESTA
%left MULTIPLICACION
%left DIVISION
%type <name> ID
%type <variable> v
%type <atributos2> e
%%
s: e FINLINEA {printf("Resultado: %d de tipo %s\n", $1.valor,
$1.tipo);}
|v FINLINEA{printf ("var %s = %d de tipo %s",$1.nombre,$1.valor,
$1.tipo);
}
;
v: ID IGUAL e {$$.nombre = $1;
$$.tipo= $3.tipo;
$$.valor = $3.valor;
//printf ("var %s = %d, de tipo %s",$$.nombre,$$.valor,$$.tipo);
}
;
e: e SUMA e             {$$.tipo= $1.tipo; $$.valor = $1.valor + $3.valor;}
 | e RESTA e            {$$.tipo= $1.tipo; $$.valor = $1.valor - $3.valor;}
 | e MULTIPLICACION e   {$$.tipo= $1.tipo; $$.valor = $1.valor *
$3.valor;}
 | e DIVISION e { $$.tipo= $1.tipo;
    if($3.valor == 0){
        yyerror("No existe division entre cero\n");
        $$.valor = -1;
        }else{
        $$.valor = $1.valor / $3.valor;
        }
    }
 | ENTERO { $$.tipo = "entero";$$.valor=$1;}
;
%%
void yyerror(char *s)
{
    printf("Error sintactico %s",s);
}
int main(int argc,char **argv)
{
    yydebug = 0;
    yyparse();
    return 0;
}
