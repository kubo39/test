use "net/http"

class Info
    let env: Env

    new iso create(env': Env) =>
        env = env'

    fun ref listening(server: Server ref) =>
        try
            (let host, let service) = server.local_address().name()
            env.out.print("Listening on " + host + ":" + service)
        else
            env.out.print("Couldn't get local address.")
            server.dispose()
        end

    fun ref not_listening(server: Server ref) =>
        env.out.print("Failed to listen.")

    fun ref closed(server: Server ref) =>
        env.out.print("Shutdown.")


primitive Handle
    fun val apply(request: Payload) =>
        let response = Payload.response()
        response.add_chunk("You asked for ")
        response.add_chunk(request.url.path)

        if request.url.query.size() > 0 then
            response.add_chunk("?")
            response.add_chunk(request.url.query)
        end

        if request.url.fragment.size() > 0 then
            response.add_chunk("#")
            response.add_chunk(request.url.fragment)
        end

        (consume request).respond(consume response)


actor Main
    new create(env: Env) =>
        let service = try env.args(1) else "8080" end
        let limit = try env.args(2).usize() else 100 end

        let logger = CommonLog(env.out)

        let auth = try
        env.root as AmbientAuth
    else
        env.out.print("unable to use network")
        return
    end

    Server(auth, Info(env), Handle, logger
    where service=service, limit=limit, reversedns=auth
    )
