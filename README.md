# cdecl

Cdecl is a program which will turn a c-language declaration into English-like phrases.

And it's one-way and very well understood.

#### Examples
```
>> int (*(*foo)(void))[3]
declare foo as pointer to function (void) returning pointer to array 3 of int

>> void (*signal(int signo,void (*func)(int)))(int)
declare signal as function (declare signo as int, declare func as pointer to function (int) returning void) returning function (int) returning pointer to function (int) returning void
```

To learn more, goto the website https://cdecl.org/
