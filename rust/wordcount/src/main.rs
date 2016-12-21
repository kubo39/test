use std::fs::File;
use std::io::{self, BufReader, BufRead};

fn word_count(filename: &str) -> io::Result<usize> {
    let f = try!(File::open(filename));
    let file = BufReader::new(&f);
    let n = file.lines()
        .map(|line| line
             .unwrap()
             .split("")
             .collect::<String>()
             .len() )
        .sum::<usize>();
    Ok(n)
}

fn main() {
    match word_count("file.txt") {
        Ok(n) => println!("{:?}", n),
        Err(err) => panic!(err.to_string())
    };
}
