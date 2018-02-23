%{
#include <iostream>
#include <string>
extern int yylex();
%}

%union{
    std::string *string;
    int token;
}

%token <string> IDENTIFIER
%token <token> INT CHAR LONG CONST FLOAT SHORT
%token <token> DOUBLE SIGNED UNSIGNED VOLATILE

%%

declaration
    : declaration_specifiers declarator '\n'
    ;

declaration_specifiers
    : type_specifier
    | type_specifier declaration_specifiers
    | type_qualifier
    | type_qualifier declaration_specifiers
    ;

type_specifier
    : VOID
    | CHAR
    | SHORT
    | INT
    | LONG
    | FLOAT
    | DOUBLE
    | SIGNED
    | UNSIGNED
    ;

type_qualifier
    : CONST
    | VOLATILE
    ;

%%