# Ponylang

## 言語

コンパイラもランタイムもCで書かれている。makeだけでビルド可能。現時点の最新は `0.10.0-ce25599ab`。

## 言語機能

組み込み型

### 動的配列

動的配列は `Array[T]` という型で表現される。

```pony
actor Main
    new create(env: Env) =>
        let arr: Array[I32] = [1, 2, 3]

        // popは例外を返しうる操作なのでtryで囲む
        try
            // popは値を返す
            let elem = arr.pop()  // => [1, 2]
        end
        arr.push(4)  // => [1, 2. 4]

        // valuesはiteratorを返す
        // iteratorを実装していればfor式によるループができる
        for i in arr.values() do
            env.out.print(i.string()) // 明示的に文字列変換
        end
```

### 文字列

文字列型は `String` として表現される。

```
actor Main
    new create(env: Env) =>
        let str = "string"

        try
            let nth = str.find("ring")  // #=> 2
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
