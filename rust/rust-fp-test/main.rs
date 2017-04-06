#[repr(C)]
struct MyStruct {
    init: unsafe extern "C" fn(*mut MyStruct),
}

#[link(name="aaa")]
extern "C" {
    fn getInstance() -> *mut MyStruct;
}

fn main() {
    // 静的に生成されるstructへのポインタを構造体として扱う
    let mut ptr = unsafe { getInstance() };
    unsafe { ((*ptr).init)(ptr) };
}
