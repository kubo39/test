#[repr(C)]
struct MyStruct {
    init: unsafe extern "C" fn(*mut MyStruct),
}

struct Outer {
    inner: *mut MyStruct,
}

impl Outer {
    fn new() -> Self {
        Outer {
            inner: unsafe { getInstance() },
        }
    }

    fn init(&mut self) {
        let raw = unsafe { &*self.inner };
        unsafe { (raw.init)(self.inner) };
    }
}

#[link(name="aaa")]
extern "C" {
    fn getInstance() -> *mut MyStruct;
}

fn main() {
    // 静的に生成されるstructへのポインタを構造体として扱う
    let mut outer = Outer::new();
    outer.init();
}
