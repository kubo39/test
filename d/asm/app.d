import std.stdio;

extern(C)
{
    int adder(int);
}

void main()
{
    writeln(adder(1));
}
