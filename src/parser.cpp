#include "SCA.h"


string Parser::genDecl()
{
    switch (iToken->token_id)
    {
    case TOKEN::TVOID:
    case TOKEN::TCHAR:
    case TOKEN::TSHORT:
    case TOKEN::TINT:
    case TOKEN::TFLOAT:
    case TOKEN::TLONG:
    case TOKEN::TDOUBLE:
        return genDeclarator(iToken++->value);
    default:
        return "syntax error";
    }
}


string Parser::genDeclarator(string type)
{
    while (iToken->token_id == TOKEN::STAR) 
    {
        type = "pointer to " + type;
        ++iToken;
    }

    if (iToken->token_id != TOKEN::IDENTIFIER && iToken->token_id != TOKEN::LPAREN) return type;

    return genDirectDeclarator(type);
}


string Parser::genDirectDeclarator(string type)
{
    string identifier;

    auto _iToken = iToken;

    if (iToken->token_id == TOKEN::IDENTIFIER) identifier = iToken++->value;
    else if (iToken->token_id == TOKEN::LPAREN)
    {
        _iToken = ++iToken;

        int n = 1;
        while (n)
        {
            if (iToken->token_id == TOKEN::LPAREN) ++n;
            else if (iToken->token_id == TOKEN::RPAREN) --n;

            ++iToken;
        }
    }


    vector<int> counts;
    vector<vector<Token>::iterator> its4backtrack;

    while (iToken->token_id == TOKEN::LBRACKET || iToken->token_id == TOKEN::LPAREN)
    {
        if (iToken->token_id == TOKEN::LPAREN)
        {
            ++iToken;
            its4backtrack.push_back(iToken);
            counts.push_back(-(int)its4backtrack.size());
            while (iToken++->token_id != TOKEN::RPAREN);
            continue;
        }

        ++iToken;
        if (iToken->token_id == TOKEN::RBRACKET)
        {
            counts.push_back(0);
            ++iToken;
            continue;
        }
        else if (iToken->token_id == TOKEN::INTEGER)
        {
            counts.push_back(stoi(iToken++->value));
            ++iToken;
            continue;
        }
        else break;
    }

    if (counts.size())
    {
        for (int i = counts.size() - 1; i >= 0; --i)
        {
            if (counts[i] > 0) type = "array " + to_string(counts[i]) + " of " + type;
            else if (counts[i] == 0) type = "array of " + type;
            else
            {
                auto _tempi = its4backtrack[-counts[i]-1];
                swap(_tempi, iToken);
                type = "function (" + genParamList() + ") returning " + type;
                swap(_tempi, iToken);
            }
        }
    }


    if (identifier.empty())
    {
        swap(_iToken, iToken);
        type = genDeclarator(type);
        swap(_iToken, iToken);
    }
    else type = "declare " + identifier + " as " + type;

    return type;
}


string Parser::genParamList()
{
    string res;
    while (iToken->token_id != TOKEN::RPAREN)
    {
        if (res.size()) res += ", ";
        res += genDecl();
        if (iToken->token_id == TOKEN::COMMA) ++iToken;
    }
    return res;
}


string Parser::parse(string line)
{
    auto tokens = Tokenizer::getTokens(line);
    iToken = tokens.begin();
    return (iToken == tokens.end()) ? "syntax error" : genDecl();
}