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
