use std::io::{self, BufRead};

fn main() {
    let stdin = Box::new(io::stdin());
    let mut lines = Box::new(stdin
                         .lock()
                         .lines()
                         .map(|line| line.unwrap().parse::<isize>().unwrap() )
                         .collect::<Vec<_>>());
    lines.sort_by(|a, b| b.cmp(a) );
    println!("{:?}", lines);
}
