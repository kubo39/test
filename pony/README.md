# Ponylang

## 言語

コンパイラもランタイムもCで書かれている。makeだけでビルド可能。

試したバージョンは

```console
$ ./build/release/ponyc --version
0.24.4-bdf48707 [release]
compiled with: llvm 3.9.1 -- cc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
Defaults: pic=true ssl=openssl_1.1.0
```

ponycはディレクトリに対してかける必要がある。

## 言語機能

- 組み込み型

### 動的配列

動的配列は `Array[T]` という型で表現される。

```pony
actor Main
    new create(env: Env) =>
        let arr: Array[I32] = [1; 2; 3]

        // popは例外を返しうる操作なのでtryで囲む
        try
            // popは値を返す
            // 要素へのアクセスは `?' を使う
            let elem = arr.pop()?  // => [1; 2]
        end
        arr.push(4)  // => [1; 2; 4]

        // valuesはiteratorを返す
        for i in arr.values() do
            env.out.print(i.string()) // 明示的に文字列変換
        end
```

### 文字列

文字列型は `String` として表現される。

```pony
actor Main
    new create(env: Env) =>
        let str = "string"

        try
            let nth = str.find("ring")?  // #=> 2
            env.out.print("\"string\".find(\"ring\"): " + nth.string())
        end

        let substr = str.substring(2)
        env.out.print("\"string\".substring(2): " + substr.string())

        // utf-8 string
        let japanese: String = "日本語"
        env.out.print(japanese)
        env.out.print(japanese.size().string())  // => 9
        env.out.print(japanese.codepoints().string())  // => 3
```

## 標準ライブラリ

### collections

連想配列やリングバッファなどのデータ構造がある。

#### 連想配列(ハッシュマップ)

連想配列型は `collections` パッケージで `Map[K, V]` として表現される。ここでは `HashMap[K, V]` をみる。

HashMapの実装方法はオープンアドレス法。

```pony
  fun _search(key: box->K!): (USize, Bool) =>
    """
    Return a slot number and whether or not it's currently occupied.
    """
    var idx_del = _array.size()
    let mask = idx_del - 1
    let h = H.hash(key).usize()  // キーのハッシュ値を取得
    var idx = h and mask  // マスクした値を最終的な値とする(値域)

    try
      // 試行回数は配列の長さを超えない
      for i in Range(0, _array.size()) do
        // バケットを取得
        let entry = _array(idx)

        // バケットにエントリがある場合
        match entry
        | (let k: this->K!, _) =>
          // キーが一致した場合
          if H.eq(k, key) then
            return (idx, true)  // 見つかった場所と見つかったという情報を返す
          end
        // 空だった場合
        | _MapEmpty =>
          // 事前に削除フラグの場所を通った場合にidx_delを再利用
          //  (削除フラグを残してしまうとホップ回数が無駄)
          if idx_del <= mask then
            return (idx_del, false)
          else
            return (idx, false)
          end
        // 削除フラグが立っていた場合
        | _MapDeleted =>
          if idx_del > mask then
            idx_del = idx
          end
        end

        // ?? probing
        //  +1, +3, +6, +10, ...
        idx = (h + ((i + (i * i)) / 2)) and mask
      end
    end

    (idx_del, false)
```

#### ソート

ソートのアルゴリズムはDual-pivot Quicksortアルゴリズム。このアルゴリズムはJavaのプリミティブ型配列などでも使われている。

### itertools

iteratorに対するmapやfilterといった操作群はこのパッケージにある。Haskellよろしく遅延評価になっている。

```pony
use "itertools"

actor Main
    new create(env: Env) =>
        Iter[I64]([as I64: 1; 2; 3; 4; 5].values())
            .map[I64]({(x: I64): I64 => x + 1 })
            .filter({(x: I64): Bool => (x % 2) == 0 })
            .map[None]({(x: I64)(env) => env.out.print(x.string()) })
            .run()  // ここで正則評価
```

## その他

### 内部実装落ち穂拾い

- 擬似乱数生成アルゴリズムはメルセンヌ・ツイスターを使用。
- 内部のハッシュ関数はSipHash24が使われている。
- 正規表現エンジンはpcre2を使ってる。
- Fibonacciクラスがある、というかmathパッケージにはそれしかない。

## パッケージマネージャ

[stable](https://github.com/jemc/pony-stable)がある。

### パッケージの追加

`stable add` コマンドを使う。

githubにあるパッケージを追加するときは `stable add` を使う。ローカルのパッケージも依存に追加できる。

たとえばこんなかんじでコマンドを叩くと、

```
$ stable add github Theodus/jennet
```

こういう `bundle.json` が生成される。

```json
{
  "deps": [
    {
      "type": "github",
      "repo": "theodus/jennet"
    }
  ]
}
```

依存パッケージをとってくるときは `stable fetch` を使う。

### 実行

依存パッケージを実行パスに含めるには `stable env` を使う。

```
stable env ponyc
```

## ウェブ開発

ウェブアプリケーションフレームワークとして[jennet](https://github.com/Theodus/jennet)がある。
