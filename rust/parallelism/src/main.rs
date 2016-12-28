extern crate rayon;
#[macro_use]
extern crate approx;

use rayon::prelude::*;

const N: usize = 1_000_000 - 1;
const DELTA: f64 = 1.0f64 / N as f64;

fn get_term(i: usize) -> f64 {
    let x = (i as f64 - 0.5f64) * DELTA;
    DELTA / (1.0 + x * x)
}

fn main() {
    let pi: f64 = 4.0 * (0..N).collect::<Vec<_>>()
        .par_iter()
        .map(|&i| get_term(i) )
        .sum();
    assert_relative_eq!(pi, 3.1415926f64, max_relative = 0.001f64);
}
