extern crate gcc;

use gcc::Config;
use std::env;
use std::process::Command;

#[cfg(all(target_arch="x86_64", target_os="linux"))]
fn assemble(out_path: &str, in_path: &str) {
    Command::new("nasm")
        .arg("-f").arg("elf64")  // See nasm -hf.
        .arg("-o").arg(out_path)
        .arg(in_path)
        .status()
        .unwrap();
}

fn main() {
    let out_dir = env::var("OUT_DIR").unwrap();
    let predict_object = format!("{}/{}", out_dir, "test.o");
    assemble(&predict_object, "test.asm");
    Config::new()
        .object(&predict_object)
        .compile("libtest.a");
}
