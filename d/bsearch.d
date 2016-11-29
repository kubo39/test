template bsearch(alias pred)
{
    import std.range.primitives;
    import std.range : isRandomAccessRange;
    size_t bsearch(Range)(Range r) if (isRandomAccessRange!Range)
    {
        import std.functional : unaryFun;
        alias _pred = unaryFun!pred;
        alias _ret = typeof(_pred(r.front));
        static if (is(_ret == bool))
        {
            size_t left = 0;
            auto right = r.length;
            while (left < right)
            {
                auto mid = left + (right - left) / 2; // avoid overflow.
                if (_pred(r[mid]))
                    right = mid;
                else
                    left = mid + 1;
            }
            return left;
        }
        else static assert(false, "Invalid predicate passed to bsearch.");
    }
}

unittest
{
    auto arr = [1, 2, 3];
    assert(arr.bsearch!(a => a > 2) == 2);
    assert(arr.bsearch!(a => a >= 1) == 0);
    assert(arr.bsearch!(a => a == 2) == 1);
    assert(arr.bsearch!"a == 4" == 3);  // got arr.length if pred == false.
}
