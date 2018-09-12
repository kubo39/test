use "itertools"

actor Main
    new create(env: Env) =>
        Iter[I64]([as I64: 1; 2; 3; 4; 5].values())
            .map[I64]({(x: I64): I64 => x + 1 })
            .filter({(x: I64): Bool => (x % 2) == 0 })
            .map[None]({(x: I64)(env) => env.out.print(x.string()) })
            .run()  // ここで正則評価
