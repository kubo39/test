extern crate gcc;

use gcc::Config;
use std::env;
use std::process::Command;

fn assemble(out_path: &str, in_path: &str) {
    Command::new("gcc")
        .arg("-Wall")
        .arg("-std=gnu11")
        .arg("-c")
        .arg("-fPIC")
        .arg("-g")
        .arg("-o").arg(out_path)
        .arg(in_path)
        .status()
        .unwrap();
}

fn main() {
    let out_dir = env::var("OUT_DIR").unwrap();
    let predict_object = format!("{}/{}", out_dir, "aaa.o");
    assemble(&predict_object, "aaa.c");
    Config::new()
        .object(&predict_object)
        .compile("libaaa.a");
}
