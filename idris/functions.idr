module Functions

-- Unary addition
plus : Nat -> Nat -> Nat
plus Z y = y
plus (S k) y = S (plus k y)

-- Unary multiplication
mult : Nat -> Nat -> Nat
mult Z y = Z
mult (S k) y = plus y S(mult k y)

-- reverse
reverse : List a -> List a
revese xs = revAcc [] xs where
  revAcc : List a -> List a -> List a
  revAcc acc [] = acc
  revAcc acc (x :: xs) = revAcc (x :: acc) xs
