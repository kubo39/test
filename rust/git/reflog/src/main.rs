extern crate git2;

use git2::Repository;

fn main() {
    let repo = match Repository::open("../../../") {
        Ok(repo) => repo,
        Err(e) => panic!("failed to open: {}", e),
    };
    let reflog = repo.reflog("HEAD").unwrap();
    for entry in reflog.iter().rev().take(3) {
        println!("sha1: {}", entry.id_new());
        println!("message: {}", entry.message().unwrap());

        let committer = entry.committer();
        println!("comitter: {}", committer);

        println!("author: {}", committer.name().unwrap());
        println!("email: {}", committer.email().unwrap());
        println!("time: {:?}", committer.when().seconds());
    }
}
