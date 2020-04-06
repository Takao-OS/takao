module lib.gc;

import memory.physical;
import memory.virtual;
import lib.glue;

T* newObj(T)(T request) {
    auto size = request.sizeof;
    assert(size <= PAGE_SIZE);

    auto result = pmmAllocAndZero(1) + MEM_PHYS_OFFSET;
    memcpy(result, &request, size);
    return cast(T*)result;
}
