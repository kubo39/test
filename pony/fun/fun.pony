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
