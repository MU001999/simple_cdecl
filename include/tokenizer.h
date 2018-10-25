#ifndef TOKENIZER_H
#define TOKENIZER_H


struct Token
{
    enum class TOKEN
    {
        END,        // $

        TVOID,      // void
        TCHAR,      // char
        TSHORT,     // short
        TINT,       // int
        TLONG,      // long
        TFLOAT,     // float
        TDOUBLE,    // double

        IDENTIFIER, // [a-zA-Z_]+[a-zA-Z0-9_]*
        INTEGER,    // [0-9]+

        LPAREN,     // (
        RPAREN,     // )
        LBRACKET,   // [
        RBRACKET,   // ]

        COMMA,      // ,
        STAR,       // *
    } token_id;

    string value;

    Token(TOKEN token_id) : token_id(token_id) {}
    Token(TOKEN token_id, string value) : token_id(token_id), value(value) {}
    Token(string value);
};


using TOKEN = Token::TOKEN;


struct Tokenizer
{
    enum class State
    {
        Begin,

        InInteger,
        InIdentifier,
    };

    static vector<Token> getTokens(string);
};


#endif // TOKENIZER_H
