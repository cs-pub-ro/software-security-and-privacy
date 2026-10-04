#include "http_parser.h"

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
	http_parser parser;
	http_parser_settings settings;
	run(&parser, &settings, (const char *)Data, Size);
	return 0;
}

