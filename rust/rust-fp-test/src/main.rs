#[repr(C)]
pub struct RLedPtr {
    init: unsafe extern "C" fn(*mut RLedPtr),
}

impl RLedPtr {
    pub fn init(&mut self) {
        unsafe {
            (self.init)(self as *mut RLedPtr)
        };
    }
}

#[link(name="xxx", kind = "static")]
extern "C" {
    fn getInstance() -> RLedPtr;
}

fn main() {
    let mut ptr: RLedPtr = unsafe { getInstance() };
    ptr.init();
}
