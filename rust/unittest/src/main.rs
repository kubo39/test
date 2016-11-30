fn bigger_than_one(n : isize) -> bool {
    n > 1
}

#[cfg(test)]
mod test {
    use bigger_than_one;
    #[test]
    fn test() {
        assert!(bigger_than_one(2));
        assert!(!bigger_than_one(0));
    }
}

fn main() {
    println!("Hello, world!");
}
