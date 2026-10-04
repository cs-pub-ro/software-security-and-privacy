#include "fuzzy.h"
#include <stddef.h>

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
	checkcrc(Size, Data);
	return 0;
}

