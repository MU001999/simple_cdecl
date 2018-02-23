%{
#include <iostream>
#include <string>
extern int yylex();
void yyerror(const char *s) { printf("ERROR: %s\n", s); }
%}

%union{
    std::string *string;
    int token;
}

%token <string> IDENTIFIER INTEGER
%token <string> INT CHAR LONG VOID CONST FLOAT SHORT
%token <string> DOUBLE SIGNED UNSIGNED VOLATILE

%type <string> declaration_specifiers type_specifier type_qualifier

%%

declaration
    : declaration_specifiers declarator { std::cout << " " << *$1 << std::endl; }
    ;

declaration_specifiers
    : type_specifier { $$ = $1; }
    | type_specifier declaration_specifiers { $$ = new std::string(*$1 + " " + *$2); }
    | type_qualifier { $$ = $1; }
    | type_qualifier declaration_specifiers { $$ = new std::string(*$1 + " " + *$2); }
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

declarator
    : pointer direct_declarator
    | direct_declarator
    ;

pointer
    : '*'
    | '*' type_qualifier_list
    | '*' pointer
    | '*' type_qualifier_list pointer
    ;

type_qualifier_list
    : type_qualifier
    | type_qualifier_list type_qualifier
    ;

direct_declarator
    : IDENTIFIER { std::cout << "Declare " << *$1 << " as"; }
    | '(' declarator ')'
    | direct_declarator '[' INTEGER ']' { std::cout << " array " << *$3 << " of"; }
    | direct_declarator '[' ']'
    | direct_declarator '(' parameter_list ')'
    | direct_declarator '(' ')'
    ;

parameter_list
    : parameter_declaration
    | parameter_list ',' parameter_declaration
    ;

parameter_declaration
    : declaration_specifiers
    | declaration_specifiers abstract_declarator
    ;

abstract_declarator
    : pointer
    | direct_abstract_declarator
    | pointer direct_abstract_declarator
    ;

direct_abstract_declarator
    : '(' abstract_declarator ')'
    | '[' ']'
    | '[' INTEGER ']'
    | direct_abstract_declarator '[' ']'
    | direct_abstract_declarator '[' INTEGER ']'
    | '(' ')'
    | '(' parameter_list ')'
    | direct_abstract_declarator '(' ')'
    | direct_abstract_declarator '(' parameter_list ')'
    ;

%%