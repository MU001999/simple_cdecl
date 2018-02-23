%{
#include <iostream>
#include <string>
#include "parser.hpp"

#define SAVE_TOKEN  yylval.string = new std::string(yytext, yyleng)
%}

delim           [ \t\n]
ws              {delim}+
id              [a-zA-Z_][a-zA-Z0-9_]*
int             [0-9]+

%option noyywrap

%%

{ws}            ;
{int}           SAVE_TOKEN; return INTEGER;

"*"             return('*');
","             return(',');

"("             return('(');
")"             return(')');
"["             return('[');
"]"             return(']');

"int"           SAVE_TOKEN; return INT;
"char"          SAVE_TOKEN; return CHAR;
"long"          SAVE_TOKEN; return LONG;
"void"          SAVE_TOKEN; return VOID;
"const"         SAVE_TOKEN; return CONST;
"float"         SAVE_TOKEN; return FLOAT;
"short"         SAVE_TOKEN; return SHORT;
"double"        SAVE_TOKEN; return DOUBLE;
"signed"        SAVE_TOKEN; return SIGNED;
"unsigned"      SAVE_TOKEN; return UNSIGNED;
"volatile"      SAVE_TOKEN; return VOLATILE;

{id}            SAVE_TOKEN; return IDENTIFIER;

%%