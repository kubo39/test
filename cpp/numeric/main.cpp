#include <iostream>
#include <numeric>
#include <vector>

int main(void)
{
  std::vector<int32_t> vec(10);
  std::iota(vec.begin(), vec.end(), 1);
  for (auto i : vec) {
    std::cout << i << " ";
  }
  std::cout << std::endl;
  return 0;
}
