use std::sync::{Arc, Mutex};
use std::thread;

#[derive(Debug)]
enum State {
    Be(usize),
    Hoge(usize, usize),
}

fn main() {
    let v: Vec<State> = vec![State::Be(1), State::Be(2), State::Be(3)];
    let status = Arc::new(Mutex::new(v));
    let mut ths = vec![];

    for i in 0..3 {
        let status = status.clone();
        ths.push(thread::spawn(move || {
            let mut status = status.lock().unwrap();
            match status[i] {
                State::Be(ref mut n) if *n == 3 => *n += 10,
                ref mut x @ State::Be(_) => *x = State::Hoge(3, 3),
                _ => panic!(),
            };
        }));
    }

    for th in ths {
        th.join().unwrap();
    }

    println!("{:?}", *status.lock().unwrap());
}
