// https://doc.rust-lang.org/std/iter/trait.Iterator.html

fn map_sample(v: &Vec<isize>) {
    let x = v.iter().map(|x| x * 2);
    println!("{:?}", x);  // Map { iter: Iter([1, 2, 3]) }
    let y: Vec<_> = x.collect();
    println!("{:?}", y);  // [2, 4, 6]
}

fn fold_sample(v: &Vec<isize>) {
    println!("{}", v.iter().fold(0, |x, y| x + y));  // 6
}

fn main() {
    let v = vec![1, 2, 3];
    map_sample(&v);
    fold_sample(&v);
}
