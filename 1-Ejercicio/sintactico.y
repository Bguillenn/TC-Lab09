%{
    #include <stdio.h>
    #define YYDEBUG 1
    extern int yylex(void);
    extern char* yytext;
    void yyerror(char*s);
%}

%union{
    struct div{
        int numerador;
        int denominador;
        int resultado;
    }division;
    int numero;
}

%token ENTRE EOL
%token <numero> NUM

%type <division> divi

%%
stm_list: stm
        | stm stm_list
;
stm: divi EOL       {
    if($1.denominador == 0){
        printf("La division entre %d y %d es igual a INDETERMINADO \n", $1.numerador, $1.denominador);
    }else{
        printf("La division entre %d y %d es igual a %d \n", $1.numerador, $1.denominador, $1.resultado);
    }
}
;
divi: NUM ENTRE NUM {
        $$.numerador = $1;
        if($3 == 0){
            $$.denominador = 0;
            $$.resultado = 0;
        }else{
            $$.denominador = $3;
            $$.resultado = $1 / $3;
        }
    }
;
%%

void yyerror(char *s){
    printf("Error sintactico: %s",s);
}

int main(){
    yydebug = 0;
    yyparse();
    return 0;
}