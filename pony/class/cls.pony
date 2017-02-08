class C
    let name: String
    new create(name': String) =>
        name = name'

    fun show(env: Env) =>
        env.out.print(name)

actor Main
    new create(env: Env) =>
        let c = C("class C")
        c.show(env)
