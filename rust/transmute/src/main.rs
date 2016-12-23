use std::mem;

fn main() {
    let a = [0u8, 1u8, 0u8, 0u8];
    let b = unsafe { mem::transmute::<[u8; 4], u32>(a) };
    assert_eq!(b, 256);
}
