// dmd -c fizzbuzz.d

auto fizzbuzz(alias n)()
{
    import std.conv : to;
    static if (n == 1) {
        return 1;
    } else {
        pragma(msg, (! (n % 15)) ? "fizzbuzz" : (! (n % 5)) ? "buzz" : (! (n % 3)) ? "fizz" : n.to!string );
        return fizzbuzz!(n - 1);
    }
}

pragma(msg, fizzbuzz!15);
