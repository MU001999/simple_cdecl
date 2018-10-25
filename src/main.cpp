#include "SCA.h"


int main(int argc, char *argv[])
{
    Parser parser;

    while (!cin.eof())
    {
        cout << ">> ";
        string line;
        getline(cin, line);

        if (line.empty()) continue;
        
        cout << parser.parse(line) << endl;
    }

    return 0;
}
