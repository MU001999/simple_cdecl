#ifndef PARSER_H
#define PARSER_H


/*
decl                : type_spec declarator
                    ;
------------------------------------------------------------------------------
type_spec           : TVOID | TCHAR | TSHORT | TINT | TLONG | TFLOAT | TDOUBLE
                    ;
------------------------------------------------------------------------------
declarator          : 
                    | pointer direct_declarator
                    | direct_declarator
                    ;
------------------------------------------------------------------------------
pointer             : STAR pointer
                    ;
------------------------------------------------------------------------------
direct_declarator   : id
                    | LPAREN declarator RPAREN
                    | direct_declarator LBRACKET RBRACKET
                    | direct_declarator LBRACKET INTEGER RBRACKET
                    | direct_declarator LBRACKET IDENTIFIER RBRACKET
                    | direct_declarator LPAREN RPAREN
                    | direct_declarator LPAREN param_list RPAREN
                    ;
------------------------------------------------------------------------------
param_list          : decl
                    | decl COMMA param_list
                    ;
*/


struct Parser
{
    vector<Token>::iterator iToken;

    string genDecl();
    string genDeclarator(string);
    string genDirectDeclarator(string);
    string genParamList();

    string parse(string);
};


#endif // PARSER_H
