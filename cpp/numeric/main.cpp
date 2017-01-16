#include <iostream>
#include <numeric>
#include <vector>

int main(void)
{
  std::vector<int32_t> vec(10);
  std::iota(vec.begin(), vec.end(), 1);  // [1,2,3,4,5,6,7,8,9,10]
  for (auto i : vec) {
    std::cout << i << " ";
  }
  std::cout << std::endl;

  auto sum = std::accumulate(vec.begin(), vec.end(), 0);
  std::cout << sum << std::endl;
  return 0;
}
