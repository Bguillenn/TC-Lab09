%{
    #include <stdio.h>
    #define YYDEBUG 1
    extern int yylex(void);
    extern char* yytext;
    void yyerror(char*s);
%}

%union{
    struct var_float{
        char* tipo;
        char* nombre;
        float valor;
    }declaracion;
    char * nombre;
    float valor;
    char igual;
}

%token FLOAT EOL PYC
%token <nombre> ID
%token <valor> REAL
%token <igual> IGUAL

%type <declaracion> dec

%%
stm_list: stm
        | stm_list stm
;
stm: dec EOL    {
    printf("Se declaro la variable de tipo %s de la siguiente manera %s \n", $1.tipo, $1.nombre);
}
;
dec: FLOAT ID IGUAL REAL PYC    {
    $$.tipo = "float";
    $$.valor = $4;
    $$.nombre = $2;
}
;
%%

void yyerror(char*s){
    printf("Error sintactico: %s", s);
}

int main(){
    yydebug = 0;
    yyparse();
    return 0;
}