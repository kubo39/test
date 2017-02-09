
## 文法

### クラス

クラス構文がある

```pony
class C
    let name: String
    new create(name': String) =>  // コンストラクタ
        name = name'

    fun show(env: Env) =>
        env.out.print(name)

actor Main
    new create(env: Env) =>
        let c = C("class C")  // コンストラクタ呼び出しはPython風
        c.show(env)
```

### 関数

関数はトップレベルに宣言できない.

```pony
actor Main
    var number: I32 = 0
    new create(env: Env) =>
        set_number(10)
        env.out.print(get_number().string())

    fun get_number(): I32 =>
        number  // return をつけるとコンパイルエラー

    // 内部状態を書き換えるコードはrefをつける必要がある
    fun ref set_number(number': I32) =>
        number = number'
```

### Primitive

[チュートリアル](https://tutorial.ponylang.org/types/primitives.html) ではprimitiveはclassのようなもので

1. フィールドをもたない
2. 単体のインスタンスを生成

D言語のEnum的なもの？

### アクター

実行主体(Context)

### Type Aliases

#### 列挙型

```pony
primitive Red
primitive Blue
primitive Green

type Colour is (Red | Blue | Green)  // 直和型
```

### Capability

属性？

ref/val/box/iso/tag/trn あたり。

チュートリアルだと[この章](https://tutorial.ponylang.org/capabilities/reference-capabilities.html) にそれぞれ説明がある。

- `iso` はisolatedの略でisolatedなデータへの参照。TLS?
- `ref` は関数のところででてきた、副作用を許容する。
- `val` はイミュータブルでかつisolatedでないデータへの参照を表す。
- `box` はread-onlyなデータへの参照。
- `trn` はtransitionの略で
- `tag` は識別のためにのみ使われる参照。tagには読み書きできない。ジェネリックプログラミングで使える？

[定数](https://tutorial.ponylang.org/generics/generic-constraints.html)の箇所でも触れられている。

### ジェネリクス

ジェネリクスはある。

```pony
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
```

## できないこと

- インラインアセンブラ
- メタプログラミング
- トップレベルでの関数定義

