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
