#[link(name="test")]
extern "C" {
    fn plus_one(n: isize) -> isize;
}

fn main() {
    let n: isize = unsafe { plus_one(1) };
    println!("{}", n);
}
