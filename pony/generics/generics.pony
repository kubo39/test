actor Main
    new create(env: Env) =>
        let foo = Foo[ISize](42)
        env.out.print(foo.get().string())

// 型パラメータ
//   [型名: 制約 参照特性] のように書く.
class Foo[A: Any val]
    var _c: A
    new create(c: A) =>
        _c = c

    fun get(): A =>
        _c

    fun ref set(c: A) =>
        _c = c
