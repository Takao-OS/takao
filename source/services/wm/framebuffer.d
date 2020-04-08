module services.wm.framebuffer;

import memory.virtual;
import lib.stivale;
import lib.alloc;
import lib.glue;

alias Colour = uint;

struct Framebuffer {
    private Colour* address;
    private Colour* doubleBuffer;
    private size_t  width;
    private size_t  height;
    private size_t  pitch;

    this(StivaleFramebuffer fb) {
        this.address      = cast(Colour*)(fb.address + MEM_PHYS_OFFSET);
        this.width        = fb.width;
        this.height       = fb.height;
        this.pitch        = fb.pitch / Colour.sizeof;
        this.doubleBuffer = newArray!Colour(fb.height * this.pitch);
    }

    invariant {
        assert(this.pitch % Colour.sizeof == 0, "Pitch is not a multiple of 4");
    }

    void putPixel(size_t x, size_t y, Colour c) {
        auto position = x + this.pitch * y;
        this.doubleBuffer[position] = c;
    }

    void clear(Colour c) {
        foreach (y; 0..this.height) {
            foreach (x; 0..this.width) {
                this.putPixel(x, y, c);
            }
        }
    }

    void refresh() {
        auto length = this.pitch * this.height * Colour.sizeof;
        memcpy(this.address, this.doubleBuffer, length);
    }

    ~this() {
        delArray(this.doubleBuffer);
    }
}
