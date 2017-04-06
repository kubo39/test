#include <stdint.h>
#include <stdio.h>

typedef struct MyStruct {
  void (*Init)(struct MyStruct* self);
} MyStruct;

typedef struct OuterStruct {
  MyStruct api;
  uint16_t pin;
} OuterStruct;


static OuterStruct outer;

void InitFunc()
{
  printf("Hello\n");
}

void gpioConstructor(OuterStruct* self)
{
  self->api.Init = InitFunc;
}

MyStruct* getInstance()
{
  // 静的領域にあるled_redに関数ポインタをひも付けている
  gpioConstructor(&outer);
  return (MyStruct*) &outer;
}
