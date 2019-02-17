// Learn more about F# at http://fsharp.org

open System

// 1.1.1 a lightweight syntax
let a_lightweight_syntax _ =
    let numbers = [ 1 .. 10 ]
    let square x = x * x in
    let squares = numbers |> List.map square
    printfn "N^2 = %A" squares

    let computeDerivative f x =
        let p1 = f (x - 0.05)
        let p2 = f (x + 0.05)
        (p2 - p1) / 0.1

    // おまけ
    let sum = squares |> List.fold (fun acc x -> x + acc) 0
    printfn "Sum = %A" sum

// 1.1.2 making data simple
let making_data_simple _ =
    let vowels = ['e'; 'i'; 'o'; 'u']
    printfn "%A" vowels
    printfn "%A" (['a'] @ vowels) // 結合

    let tuple = (1, false, "text")
    let getNumberInfo (x: int) = (x, x.ToString(), x * x) in
    printfn "%A" (getNumberInfo 42)

// 1.1.3 making types simple
let making_types_simple _ =
    let swap (a, b) = (b, a) in
    swap(1, 2) |> ignore
    swap("you", true) |> ignore

// 1.1.4 functional programming
let functional_programming _ =
    let arr = [ 1 .. 5] |> List.map (fun x -> x % 2 = 0)
    printfn "%A" arr

    let checkList alist =
        match alist with
        | [] -> 0
        | [a] -> 1
        | [a; b] -> 2
        | [a; b; c] -> 3
        | _ -> failwith "List is too big!"
        in

    // let getType (x : obj) =
    //     match x with
    //     | :? string -> "x is string"
    //     | :? int -> "x is int"
    //     | :? System.Exception -> "x is an exception"
    //     in

    let square x = x * x in
    let toStr (x : int) = x.ToString() in
    let reverse (x : string) = new System.String(Array.rev (x.ToCharArray())) in
    let result = 32 |> square |> toStr |> reverse
    printfn "%A" result

// 1.1.5 imperative programming
let imperative_programming _ =
    printfn "%d * %f = %s" 5 0.75 ((5.0 * 0.75).ToString())

// 1.1.7 parallel and asynchronous programming
let parallel_and_asynchronous_programming _ =
    let rec fib x = if x < 2 then 1 else fib(x-1) + fib(x-2) in
    let fibs =
        Async.Parallel [ for i in 0..40 -> async { return fib(i) } ]
        |> Async.RunSynchronously
    printfn "The fibonacci numbers are %A" fibs

// 1.1.9 object oriented programming and code organization
type CharMapEncoder (symbols: seq<char*char>) =
    let swap (x, y) = (y, x) in
    let fwd = symbols |> Map.ofSeq
    let bwd = symbols |> Seq.map swap |> Map.ofSeq

    let encode (s:string) =
        String[| for c in s -> if fwd.ContainsKey(c) then fwd.[c] else c|]
        in
    let decode (s:string) =
        String[| for c in s -> if bwd.ContainsKey(c) then bwd.[c] else c|]
        in

    member x.Encode(s) = encode s

    member x.Decode(s) = decode s

let object_oriented_programming _ =
    let rot13 (c:char) =
        char(int 'a' + ((int c - int 'a' + 13) % 26))
        in
    let encoder = CharMapEncoder([ for c in 'a' .. 'z' -> (c, rot13 c)])

    printfn "%A" ("F# is fun!" |> encoder.Encode)
    printfn "%A" ("F# is fun!" |> encoder.Encode |> encoder.Decode)

[<EntryPoint>]
let main argv =
    // 1.1.1 lightweight syntax
    a_lightweight_syntax ()

    // 1.1.2 making data simple
    making_data_simple ()

    // 1.1.3 making types simple
    making_types_simple ()

    // 1.1.4 functional programming
    functional_programming ()

    // 1.1.5 imperative programming
    imperative_programming ()

    // 1.1.7 parallel and asynchronous programming
    parallel_and_asynchronous_programming ()

    // 1.1.9 object oriented programming and code organization
    object_oriented_programming ()

    0 // return an integer exit code
