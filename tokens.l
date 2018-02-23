%{
#include <stdio.h>
#define SAVE_TOKEN  yylval.string = new std::string(yytext, yyleng)
%}

delim           [ \t]
ws              {delim}+
id              [a-zA-Z_][a-zA-Z0-9_]*
int             [0-9]+

%option noyywrap

%%

{ws}            ;
{int}           SAVE_TOKEN; return INTEGER;
"\n"            return('\n'); 

"*"             return('*');
","             return(',');

"("             return('(');
")"             return(')');
"["             return('[');
"]"             return(']');

"int"           return(INT);
"char"          return(CHAR);    
"long"          return(LONG);
"const"         return(CONST);
"float"         return(FLOAT);
"short"         return(SHORT);
"double"        return(DOUBLE);
"signed"        return(SIGNED);
"unsigned"      return(UNSIGNED);
"volatile"      return(VOLATILE);

{id}            SAVE_TOKEN; return(IDENTIFIER);

%%