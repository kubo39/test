extern crate fringe;

use fringe::{OsStack, Generator};

fn main() {
    let stack = OsStack::new(1 << 20).unwrap(); // Stack: 1MB
    let mut gen = Generator::new(stack, move |yielder, ()| {
        for i in 1 .. 4 {
            yielder.suspend(i);
        }
    });
    println!("{:?}", gen.resume(()));  // Some(1)
    println!("{:?}", gen.resume(()));  // Some(2)
    println!("{:?}", gen.resume(()));  // Some(3)
    println!("{:?}", gen.resume(()));  // None
}
