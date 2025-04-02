// usage
//
//   ❯ nanos
//   1235239100885250
//   ❯ nanos --ms
//   1235241912
//
// compile
//
//   gcc nanos.c -o nanos
//
#include <inttypes.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include <mach/mach_time.h>

int main(int argc, char **argv)
{
  uint64_t t = mach_absolute_time();

  // ratio between mach_absolute_time units and nanoseconds
  mach_timebase_info_data_t data;
  mach_timebase_info(&data);

  // convert to nanoseconds
  t *= data.numer;
  t /= data.denom;

  // check for '--ms' flag to optionally print milliseconds
  if (argc > 1 && strcmp(argv[1], "--ms") == 0) {
      // convert to milliseconds
      t /= 1e6;
  }

  printf("%" PRIu64 "\n", t);

  return 0;
}
