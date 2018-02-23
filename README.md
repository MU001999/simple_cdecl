# cdecl

Cdecl is a program which will turn a c-language declaration into English-like phrases.And it's one-way and very well understood.<br>

Unfortunately, it is only a very simple implementation of cdecl by lex & yacc :( <br>

###### example
```
$ ./simple_cdecl
int (*(*foo)(void ))[3]
Declare foo as pointer to function (void) returning pointer to array 3 of int
```

To learn more, goto the repo https://github.com/cyyzero/incompetent_cdecl.