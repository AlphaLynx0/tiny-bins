# Tiny Binaries

A collection of assembly programs crafted for extremely minimal executable size.

## ⚠️ Educational Use Only

These are proof-of-concept programs prioritizing size over security and portability. Do not use in production.

## Why?

A regular hello world program in C compiles to ~14 kilobytes. This project explores how small we can make these binaries through assembly optimization—a fun challenge in understanding the costs of abstraction.

## How?

Size reductions are achieved by:

- **Minimal ELF header** instead of standard format
- **No C runtime boilerplate** (entry point setup, initialization)
- **Direct syscalls** (matching what optimized C would do anyway)
- **Making unsafe assumptions** (e.g., registers pre-zeroed, specific environment)
- **Stripping all error handling** for the sake of size

Result: hello-world in 115 bytes vs. 14 KB—a 122x reduction.

## Prerequisites

- NASM
- GCC
- GNU make

## Status

- [x] hello-world (115 bytes)
- [ ] factorial
- [ ] fibonacci
- [ ] echo
- [ ] date
- [ ] simple HTTP "Hello" server
- [ ] GNU Coreutils

## Build & Test

```bash
# clone the repo
git clone https://github.com/AlphaLynx0/tiny-bins.git
cd tiny-bins/hello-world

# assemble, compile, and compare both versions
make savings
```

Each subdirectory follows the same pattern:
- `make` builds both the ASM and C versions
- `make savings` compares their sizes
- `make clean` deletes binaries
- `make test` (if implemented) tests the output of ASM and reference binaries

## License

MIT © AlphaLynx <alphalynx@alphalynx.dev>
