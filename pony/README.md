# Ponylang

## 言語

コンパイラもランタイムもCで書かれている。makeだけでビルド可能。現時点の最新は `0.10.0-ce25599ab`。

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
