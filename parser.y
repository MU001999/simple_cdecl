%{
#include <iostream>
#include <string>
extern int yylex();
%}

%union{
    std::string *string;
    int token;
}

%token <string> IDENTIFIER INTEGER
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
    : IDENTIFIER
    | '(' declarator ')'
    | direct_declarator '[' INTEGER ']'
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