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
